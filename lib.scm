;;;;;;;;;;;;
;; SYNTAX ;;
;;;;;;;;;;;;

(define-syntax letin
  (syntax-rules ()
    [(letin body) body]
    [(letin ((a . as) b) body ...)
     (let-values [[[a . as] b]] (letin body ...))]
    [(letin (a b) body ...)
     (let [[a b]] (letin body ...))]))

(define-syntax defloop
  (lambda (stx)
    (syntax-case stx ()
      [(defloop lambda-list . body)
       (with-syntax ([name (datum->syntax #'body 'loop)])
         #'(letrec ([name (lambda lambda-list . body)])
             name))])))

(define-syntax-rule [apploop args argv . body]
  ((defloop args . body) . argv))

(define-macro (reversed-args . body)
  (reverse body))

(define-syntax reversed-lambda
  (syntax-rules ()
    [(reversed-lambda body args) (lambda [] body)]
    [(reversed-lambda body args next) (lambda (next . args) body)]
    [(reversed-lambda body args x next ...) (reversed-lambda body (x . args) next ...)]))

(define-syntax fn-start
  (syntax-rules ()
    [(fn-start args body) (reversed-lambda body () . args)]
    [(fn-start args x body ...) (fn-start (x . args) body ...)]))

(define-syntax-rule [fn . argv] (fn-start () . argv))

(define-syntax fn-list-g
  (syntax-rules ()
    [(fn-list-g lst body) body]
    [(fn-list-g lst x body ...)
     (let [[x (car lst)]]
       (fn-list-g
        (cdr lst)
        body
        ...))]))

(define-syntax-rule [fn-list . args]
  (lambda [lst] (fn-list-g lst . args)))

(define-syntax with-return
  (lambda (stx)
    (syntax-case stx ()
      [(define-job . bodies)
       (with-syntax [[return (datum->syntax #'bodies 'return)]]
         #'(call/cc (lambda [return] (begin . bodies))))])))

(define-syntax monoids*
  (syntax-rules ()
    [(monoids* x) x]
    [(monoids* op x) (op x)]
    [(monoids* a op b next-op ...)
     (monoids* (op a b) next-op ...)]))

(define-syntax monoids-r*
  (syntax-rules ()
    [(monoids-r* x) x]
    [(monoids-r* op x) (op x)]
    [(monoids-r* a op b next-op ...)
     (op a (monoids-r* b next-op ...))]))

(define-syntax monoid-r*
  (syntax-rules ()
    [(monoid-r* op a) a]
    [(monoid-r* op a b ...)
     (op a (monoid-r* op b ...))]))

(define-syntax monoid*
  (syntax-rules ()
    [(monoid* op a) a]
    [(monoid* op a b c ...)
     (monoid* op (op a b) c ...)]))

;; like do syntax in haskell
(define-syntax letin-with-full
  (syntax-rules ()
    [(letin-with-full f body) body]
    [(letin-with-full f (a b) body ...)
     (f (quote a)
        (quote b)
        b
        (lambda [a]
          (letin-with-full f
                           body
                           ...)))]))

(define letin-global-monad-parameter (make-parameter #f))
(define-syntax-rule [letin-parameterize f . body]
  (parameterize [[letin-global-monad-parameter f]]
    (begin . body)))

;; with parameterization
(define-syntax-rule [letin-with-full-parameterized f . argv]
  (let [[p (letin-global-monad-parameter)]]
    (if p
        (letin-with-full (p f (quote f)) . argv)
        (letin-with-full f . argv))))

(define-syntax-rule [letin-with f . argv]
  (letin-with-full-parameterized (lambda [name result x cont] (f x cont)) . argv))

(define-syntax-rule [letin-with-identity . argv]
  (letin-with (fn x cont (cont x)) . argv))

(define-syntax-rule [dom . argv] (letin-with . argv))

(define-syntax-rule [domid . argv] (letin-with-identity . argv))

(define-syntax-rule [domf . argv] (letin-with-full . argv))

;; Short circuits with any predicate
(define [dom-default default?]
  (fn x cont
      (if (default? x)
          x
          (cont x))))

;;;;;;;;;;;;;;;;
;; SHORTHANDS ;;
;;;;;;;;;;;;;;;;

(define [~a x]
  (with-output-to-string
    (lambda []
      (display x))))

(define [range start count]
  (if (> count 0)
      (cons start (range (1+ start) (1- count)))
      (list)))

(define [list-init lst]
  (take lst (1- (length lst))))

(define [second-to-microsecond s]
  (* 1000000 s))

(define [microsecond-to-nanosecond ms]
  (* 1000 ms))

(define [second-to-nanosecond s]
  (microsecond-to-nanosecond (second-to-microsecond s)))

(define [nanosecond-to-microsecond ns]
  (quotient ns 1000))

(define [make-unique]
  "Returns procedure that returns #t if applied to itself, #f otherwise"
  (letrec [[me (lambda [other] (eq? other me))]] me))

(define [generic-fold first-f rest-f stop-predicate initial collection function]
  (let lp [[acc initial]
           [rest collection]]
    (if (stop-predicate rest)
        acc
        (lp (function acc (first-f rest) rest) (rest-f rest)))))

(define-macro [generic-fold-macro first-f
                                  rest-f
                                  stop-predicate
                                  initial
                                  collection
                                  . body]
  `(generic-fold ,first-f ,rest-f ,stop-predicate ,initial ,collection
                   (lambda [acc x rest] ,@ body)))

(define [list-fold initial lst function]
  (generic-fold car cdr null? initial lst
                (lambda [acc x rest] (function acc x))))

(define [list-fold/rest initial lst function]
  (generic-fold car cdr null? initial lst function))

(define-macro [lfold initial lst . body]
  `(generic-fold-macro car cdr null? ,initial ,lst ,@ body))

(define [simplify-posix-path path]
  (let* [[splits (string-split#simple path #\/)]
         [rev
          (let lp [[buf (list)] [rest splits]]
            (if (null? (cdr rest))
                (cons (car rest) buf)
                (let [[cur (car rest)]
                      [next (car (cdr rest))]]
                  (if (string=? next "..")
                      (lp buf (list-tail rest 2))
                      (if (string=? cur ".")
                          (lp buf (cdr rest))
                          (lp (cons cur buf) (cdr rest)))))))]
         [norm (reverse rev)]
         [ret (string-join norm "/")]]
    ret))

(define [append-posix-path2 a b]
  (if (= (string-length a) 0)
      b
      (begin
        (when (char=? (string-ref b 0) #\/)
          (throw 'append-posix-path-error `(args: ,a ,b) '(trying to append root path)))
        (if (char=? #\/ (string-ref a (1- (string-length a))))
            (string-append a b)
            (string-append a "/" b)))))

(define [append-posix-path . paths]
  (list-fold "" paths append-posix-path2))

;;;;;;;;;;;;;
;; BRACKET ;;
;;;;;;;;;;;;;

(define [with-bracket-dw expr finally]
  (call/cc
   (lambda [k]
     (dynamic-wind
       (lambda [] 0)
       (lambda [] (expr k))
       finally))))

(define with-bracket-lf
  (let [[dynamic-stack (make-parameter (list))]]
    (lambda [expr finally]
      (let* [[err #f] [normal? #t]
             [finally-executed? #f]
             [finally-wraped
              (lambda args
                (unless finally-executed?
                  (set! finally-executed? #t)
                  (apply finally args)))]]
        (catch-any
          (lambda []
            (call/cc
             (lambda [k]
               (parameterize
                   [[dynamic-stack
                     (cons (cons k finally-wraped) (dynamic-stack))]]
                 (expr (lambda argv
                         (set! normal? #f)

                         (let lp [[st (dynamic-stack)]]
                           (unless (null? st)
                             (let [[p (car st)]]
                               ((cdr p))
                               (when (not (eq? (car p) k))
                                 (lp (cdr st))))))

                         (apply k argv)
                         ))))))
          (lambda args
            (set! err args)))
        (when normal? (finally-wraped))
        (when err (apply throw err))))))

(define [with-bracket expr finally]
  "
  Applies `return' function to expr.
  `return' is a call/cc function, but it ensures that `finally' is called.
  Also, if exception is raised, `finally' executes.
  Composable, so that if bottom one calls `return', all `finally's are going to be called in correct order.
  Returns unspecified

  This is different from `with-bracket-dw' (dynamic-wind)
  because it executes `finally' before returning the control
  and it does not catch any non local jumps except the `return' and throws

  expr ::= ((Any -> Any) -> Any)
  finally ::= (-> Any)
  "
  (with-bracket-lf expr finally))

;;;;;;;;;;;;;;;;
;; SHORTHANDS ;;
;;;;;;;;;;;;;;;;

(define-syntax-rule [with-lock mutex . bodies]
  (call-with-blocked-asyncs
   (lambda []
     (my-mutex-lock! mutex)
     (let [[ret (begin . bodies)]]
       (my-mutex-unlock! mutex)
       ret))))

(define [stringf fmt . args]
  (with-output-to-string
    (lambda []
      (apply printf (cons* fmt args)))))

(define [println fmt . args]
  (apply printf (cons* (string-append fmt "\n") args)))

(define global-debug-mode-filter (make-parameter #f))

(define [debug fmt . args]
  (let [[p (global-debug-mode-filter)]]
    (when (or (not p) (and p (p fmt args)))
      (apply printf (cons* fmt args)))))

;; Logs computations
(define [dom-print name result x cont]
  (printf "(~a = ~a = ~a)\n" name x result)
  (cont x))

(define [port-redirect from to]
  "Redirect from `from' to `to' byte by byte, until `eof-object?'
   Returns count of written bytes

   type ::= port -> port -> int
  "
  (let lp [[count 0]]
    (let [[byte (get-u8 from)]]
      (if (eof-object? byte)
          count
          (begin
            (put-u8 to byte)
            (lp (1+ count)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NON PREEMPTIVE THREADS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-values
  [np-thread-list-add
   np-thread-list-pop
   np-thread-list-init
   np-thread-list-initialized?
   np-thread-list-remove
   ]
  (let* [[lst-p (make-parameter #f)]
         [mut (my-make-mutex)]]
    (values
     (lambda [th]
       (with-lock
        mut
        (set-box! (lst-p) (cons th (unbox (lst-p))))))
     (lambda []
       (with-lock
        mut
        (let* [[lst (unbox (lst-p))]
               [head
                (if (null? lst)
                    'np-thread-empty-list
                    (last lst))]]
          (unless (null? lst)
            (set-box! (lst-p) (list-init lst)))
          head)))
     (lambda [body]
       (parameterize [[lst-p (box (list))]]
         (body)))
     (lambda []
       (if (lst-p) #t #f))
     (lambda [predicate]
       (with-lock
        mut
        (set-box! (lst-p)
                  (filter (negate predicate)
                          (unbox (lst-p)))))))))

(define-values
  [np-thread-get-start-point
   np-thread-set-start-point]
  (let [[p (make-parameter (lambda [] 0))]]
    (values
     (lambda [] (p))
     (lambda [value thunk]
       (parameterize [[p value]]
         (np-thread-list-init thunk))))))

(define [np-thread-end]
  (let [[p (np-thread-list-pop)]]
    (if (eq? p 'np-thread-empty-list)
        ((np-thread-get-start-point))
        (begin
          (p #t)
          (np-thread-end)))))

(define [np-thread-yield]
  (when (np-thread-list-initialized?)
    (let* [[kk #f]
           [repl (call/cc (lambda [k] (set! kk k) #f))]]
      (unless repl
        (np-thread-list-add kk) ;; save
        (np-thread-end)))))

(define [np-thread-fork thunk]
  (unless (np-thread-list-initialized?)
    (throw 'np-thread-forking-before-run!
           `(args: ,thunk)
           `(tried to fork np-thread before np-thread-run!)))

  (np-thread-list-add
   (lambda [tru]
     (thunk)
     (np-thread-end))))

(define-syntax-rule [np-thread-run! . thunk]
  (call/cc
   (lambda [k]
     (np-thread-set-start-point
      k
      (lambda []
       (begin . thunk)
       (np-thread-end))))))

(define-values
  [np-thread-sleep-rate-ms
   np-thread-sleep-rate-ms-set!]
  (let [[p (make-parameter (second-to-microsecond 1/100))]]
    (values
     (lambda [] (p))
     (lambda [value body]
       (parameterize [[p value]] (body))))))

(define [np-thread-usleep micro-seconds]
  (let* [[nano-seconds (microsecond-to-nanosecond micro-seconds)]
         [start-time (time-get-monotonic-nanoseconds-timestamp)]
         [end-time (+ start-time nano-seconds)]
         [sleep-rate (np-thread-sleep-rate-ms)]]
    (let lp []
      (let [[t (time-get-monotonic-nanoseconds-timestamp)]]
        (unless (> t end-time)
          (let [[s (min sleep-rate
                        (nanosecond-to-microsecond (- end-time t)))]]
            (np-thread-yield)
            (usleep s)
            (lp)))))))

(define [np-thread-cancel!]
  "Terminates current np-thread"
  (np-thread-end))

(define [np-thread-cancel-all!]
  "
  Terminates all threads on current thread group
  "
  (np-thread-list-remove (const #t))
  (np-thread-end))

;; TODO: cancel chosen thread

(define-values
  [np-thread-lockr! np-thread-unlockr!]
  (let [[mut (my-make-mutex)]
        [h (make-hash-table)]]
    (values
     (lambda [resource]
       (let lp []
         ((with-lock
           mut
           (if (hash-ref h resource #f)
               (lambda []
                 (np-thread-usleep (np-thread-sleep-rate-ms))
                 (lp))
               (begin
                 (hash-set! h resource #t)
                 (lambda [] 0)))))))
     (lambda [resource]
       (with-lock
        mut
        (hash-set! h resource #f))))))

;;;;;;;;;;;;;;;
;; PROCESSES ;;
;;;;;;;;;;;;;;;

(define [kill-comprocess-with-timeout p timeout]
  (unless (comprocess-exited? p)
    (call-with-new-sys-thread
     (lambda []
       (kill-comprocess p #f)
       (usleep timeout)
       (unless (comprocess-exited? p)
         (kill-comprocess p #t))))))

