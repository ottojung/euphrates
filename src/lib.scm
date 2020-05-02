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

(define-syntax reversed-args-buf
  (syntax-rules ()
    ((_ (x . xs) buf)
     (reversed-args-buf xs (x . buf)))
    ((_ () buf)
     buf)))
(define-syntax-rule (reversed-args . args)
  (reversed-args-buf args ()))

(define-syntax reversed-args-f-buf
  (syntax-rules ()
    ((_ f (x . xs) buf)
     (reversed-args-f-buf f xs (x . buf)))
    ((_ f () buf)
     (f . buf))))
(define-syntax-rule (reversed-args-f f . args)
  (reversed-args-f-buf f args ()))

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

(begin-for-syntax
 (define-syntax-rule [generate-prefixed-name prefix name]
   (format-id name "~a~a" prefix (syntax->datum name))))

;;;;;;;;;;;;;;;;
;; SHORTHANDS ;;
;;;;;;;;;;;;;;;;

(define [take-common-prefix a b]
  (list->string
   (let loop [[as (string->list a)]
              [bs (string->list b)]]
     (if (or (null? as)
             (null? bs))
         (list)
         (if (char=? (car as) (car bs))
             (cons (car as)
                   (loop (cdr as) (cdr bs)))
             (list))))))

(define (lines str)
  (string-split str #\newline))
(define (unlines lns)
  (string-join lns "\n"))

(define-syntax assert
  (syntax-rules ()
    ((assert test)
     (unless test
       (throw 'assertion-fail
              `(test: ,(quote test)))))
    ((assert test . printf-args)
     (unless test
       (throw 'assertion-fail
              `(test: ,(quote test))
              `(description: ,(stringf . printf-args)))))))

(define-syntax assertNormBuf
  (syntax-rules ()
    ((_ orig buf (last-r))
     (let ((last last-r))
       (unless (reversed-args last . buf)
         (throw 'assertion-fail
                `(test: ,(quote orig))
                `(test!: ,(reversed-args-f list last . buf))))))
    ((_ orig buf (last-r) . printf-args)
     (let ((last last-r))
       (unless (reversed-args last . buf)
         (throw 'assertion-fail
                `(test: ,(quote orig))
                `(test!: ,(reversed-args-f list last . buf))
                `(description: ,(stringf . printf-args))))))
    ((_ orig buf (x-r . xs-r) . printf-args)
     (let ((x x-r))
       (assertNormBuf orig (x . buf) xs-r . printf-args)))))

;; reduces test to normal form by hand
(define-syntax assertNorm
  (syntax-rules ()
    ((_ (x . xs) . printf-args)
     (assertNormBuf (x . xs) () (x . xs) . printf-args))
    ((_ test . printf-args)
     (assert test . printf-args))))

(define range
  (case-lambda
    ((start count)
     (if (> count 0)
         (cons start (range (1+ start) (1- count)))
         (list)))
    ((count)
     (range 0 count))))

(define [list-init lst]
  (take lst (1- (length lst))))

(define [normal->micro@unit s]
  (* 1000000 s))

(define [micro->nano@unit ms]
  (* 1000 ms))

(define [normal->nano@unit s]
  (micro->nano@unit (normal->micro@unit s)))

(define [nano->micro@unit ns]
  (quotient ns 1000))

(define [micro->normal@unit u]
  (quotient u 1000000))

(define [nano->normal@unit n]
  (quotient n (* 1000 1000000)))

(define [make-unique]
  "Returns procedure that returns #t if applied to itself, #f otherwise"
  (let ((me #f))
    (set! me (lambda (other)
               (eq? other me)))
    me))

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

;; TODO: make something safe instead?
(define (make-temporary-filename)
  (let* ((rand (big-random-int 99999999999))
         (s (with-output-to-string
              (lambda () (display rand)))))
    (string-append "/tmp/euphrates-temp-" s)))

(define [stringf fmt . args]
  (with-output-to-string
    (lambda []
      (apply printf (cons* fmt args)))))

(define [printfln fmt . args]
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

(define-syntax-rule (cons! x lst)
  (set! lst (cons x lst)))

; memoized constant function
(define-syntax-rule (memconst x)
  (let ((memory #f)
        (evaled? #f))
    (lambda argv
      (unless evaled?
        (set! evaled? #t)
        (set! memory x))
      memory)))

(define (replicate n x)
  (if (= 0 n)
      (list)
      (cons x (replicate (1- n) x))))

;;; thread abstractions

(define dynamic-thread-spawn-p (make-parameter call-with-new-sys-thread))
(define (dynamic-thread-spawn thunk) ((dynamic-thread-spawn-p) thunk))

(define dynamic-thread-cancel-p (make-parameter cancel-sys-thread))
(define (dynamic-thread-cancel thunk) ((dynamic-thread-cancel-p) thunk))

(define dynamic-thread-yield-p (make-parameter (lambda () 0)))
(define (dynamic-thread-yield) ((dynamic-thread-yield-p)))

(define dynamic-thread-wait-delay#us-p
  (make-parameter (normal->micro@unit 1/100)))

(define dynamic-thread-sleep-p (make-parameter usleep))
(define [dynamic-thread-sleep micro-seconds]
  ((dynamic-thread-sleep-p) micro-seconds))

;; NOTE ON USING MUTEXES AND CRITICAL ZONES
;; Critical zones must not evaluate non-local
;; jumps, such as exceptions!
;; np-thread and others rely on this.
;; Use critical zones where it is clear that
;; code doesn't have jumps because they are
;; faster than locks, for some contexts,
;; and are easier to use
;; Otherwise, use locks
;; When parameterizing locks/critical-zones
;; make sure that application uses compatible
;; set of thread-model/blocking-methods pairs
;; For example, if application uses posix threads
;; along with np-thread's, they you should use
;; uni-spinlocks which are the most strict one

(define (dynamic-thread-mutex-make)
  ((dynamic-thread-mutex-make-p)))
(define (dynamic-thread-mutex-lock! mut)
  ((dynamic-thread-mutex-lock!-p) mut))
(define (dynamic-thread-mutex-unlock! mut)
  ((dynamic-thread-mutex-unlock!-p) mut))

(define (dynamic-thread-critical-make#default)
  (let* ((mut (dynamic-thread-mutex-make))
         (lock-func (dynamic-thread-mutex-lock!-p))
         (unlock-func (dynamic-thread-mutex-unlock!-p))
         (lock (lambda () (lock-func mut)))
         (unlock (lambda () (unlock-func mut))))
    (lambda (thunk)
        (lock)
        (thunk)
        (unlock))))

(define dynamic-thread-critical-make-p
  (make-parameter dynamic-thread-critical-make#default))
(define (dynamic-thread-critical-make)
  ((dynamic-thread-critical-make-p)))

;; Universal spinlock
;; Works for any thread model
;; Very wasteful
(define-values
    (make-uni-spinlock
     uni-spinlock-lock!
     uni-spinlock-unlock!
     make-uni-spinlock-critical)

  (let* ((make (lambda () (make-atomic-box #f)))

         (lock
          (lambda (o)
            (let ((yield (dynamic-thread-yield-p)))
              (let lp ()
                (unless (atomic-box-compare-and-set!
                         o #f #t)
                  (yield)
                  (lp))))))

         (unlock
          (lambda (o)
            (atomic-box-set! o #f)))

         (critical
          (lambda ()
            (let ((box (make)))
              (lambda (thunk)
                  (lock box)
                  (thunk)
                  (unlock box))))))
    (values make lock unlock critical)))

(define-syntax-rule (with-critical critical-func . bodies)
  (critical-func
   (lambda [] . bodies)))

(define-syntax-rule [sleep-until condi . body]
  (let ((period (dynamic-thread-wait-delay#us-p))
        (dynamic-thread-sleep-func (dynamic-thread-sleep-p)))
    (do ()
        (condi)
      (dynamic-thread-sleep-func period)
      . body)))

;; Like uni-spinlock but use arbitary variables as lock target
;; and do sleep when wait
(define-values
  [universal-lockr! universal-unlockr!]
  (let [[critical (make-uni-spinlock-critical)]
        [h (make-hash-table)]]
    (values
     (lambda [resource]
       (let ((sleep (dynamic-thread-sleep-p))
             (timeout (dynamic-thread-wait-delay#us-p)))
         (let lp []
           (when
               (with-critical
                critical
                (let [[r (hash-ref h resource #f)]]
                  (if r
                      #t
                      (begin
                        (hash-set! h resource #t)
                        #f))))
             (sleep timeout)
             (lp)))))
     (lambda [resource]
       (with-critical
        critical
        (hash-set! h resource #f))))))

(define [universal-usleep micro-seconds]
  (let* [[nano-seconds (micro->nano@unit micro-seconds)]
         [start-time (time-get-monotonic-nanoseconds-timestamp)]
         [end-time (+ start-time nano-seconds)]
         [sleep-rate (dynamic-thread-wait-delay#us-p)]
         [yield (dynamic-thread-yield-p)]]
    (let lp []
      (let [[t (time-get-monotonic-nanoseconds-timestamp)]]
        (unless (> t end-time)
          (let [[s (min sleep-rate
                        (nano->micro@unit (- end-time t)))]]
            (yield)
            (usleep s)
            (lp)))))))

;;;;;;;;;;;;
;; MONADS ;;
;;;;;;;;;;;;

(define-syntax monadic-bare-handle-tags
  (syntax-rules ()
    ((monadic-bare-handle-tags ())
     (list))
    ((monadic-bare-handle-tags . tags)
     (list . tags))))

;; like do syntax in haskell
(define-syntax monadic-bare
  (syntax-rules ()
    [(monadic-bare f body)
     (let-values
         (((r-x r-cont qvar qval qtags)
           (f (const body)
              identity
              (quote ())
              (quote body)
              (quote ()))))
       (r-cont (r-x)))]
    [(monadic-bare f ((a . as) b . tags) body ...)
     (let-values
         (((r-x r-cont qvar qval qtags)
           (f (lambda [] (call-with-values (lambda [] b) (lambda x x)))
              (lambda [k]
                (apply
                 (lambda [a . as]
                   (monadic-bare f
                                 body
                                 ...))
                 k))
              (quote (a . as))
              (quote b)
              (monadic-bare-handle-tags . tags))))
       (r-cont (r-x)))]
    [(monadic-bare f (a b . tags) body ...)
     (let-values
         (((r-x r-cont qvar qval qtags)
           (f (lambda [] b)
              (lambda [a]
                (monadic-bare f
                              body
                              ...))
              (quote a)
              (quote b)
              (monadic-bare-handle-tags . tags))))
       (r-cont (r-x)))]))

(define monadic-global-parameter (make-parameter #f))
(define-syntax-rule [monadic-parameterize f . body]
  (parameterize [[monadic-global-parameter f]]
    (begin . body)))

;; with parameterization
(define-syntax-rule [monadic fexpr . argv]
  (let* [[p (monadic-global-parameter)]
         [f fexpr]]
    (if p
        (monadic-bare (p f (quote f)) . argv)
        (monadic-bare f . argv))))

(define-syntax-rule [monadic-id . argv]
  (monadic identity-monad . argv))

(define (monad-arg monad-input)
  (first monad-input))
(define (monad-cont monad-input)
  (second monad-input))
(define (monad-qvar monad-input)
  (third monad-input))
(define (monad-qval monad-input)
  (fourth monad-input))
(define (monad-qtags monad-input)
  (fifth monad-input))

(define (monad-last-val? monad-input)
  (null? (monad-qvar monad-input)))

(define (monad-cret monad-input arg cont)
  (values arg
          cont
          (monad-qvar monad-input)
          (monad-qval monad-input)
          (monad-qtags monad-input)))
(define (monad-ret monad-input arg)
  (values arg
          (monad-cont monad-input)
          (monad-qvar monad-input)
          (monad-qval monad-input)
          (monad-qtags monad-input)))

(define (monad-handle-multiple monad-input arg)
  (let* ((qvar (monad-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (const (replicate len (arg))))))
(define (monad-replicate-multiple monad-input arg)
  (let* ((qvar (monad-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (replicate len arg))))

(define (except-monad)
  (let ((exceptions (list)))
    (lambda monad-input
      (if (monad-last-val? monad-input)
          (monad-ret monad-input
                     (monad-handle-multiple
                      monad-input
                     (if (null? exceptions)
                         (monad-arg monad-input)
                         (memconst (apply throw 'except-monad exceptions)))))
          (if (or (null? exceptions)
                  (memq 'always (monad-qtags monad-input)))
              (monad-ret monad-input
                         (memconst (catch-any
                                    (monad-arg monad-input)
                                    (lambda args
                                      (cons! args exceptions)
                                      (monad-replicate-multiple
                                       monad-input
                                       'monad-except-default)))))
              (monad-ret monad-input
                         (monad-handle-multiple
                          monad-input
                         (const 'monad-except-default))))))))

(define log-monad
  (lambda monad-input
    (printf "(~a = ~a = ~a)\n"
            (monad-qvar monad-input)
            ((monad-arg monad-input))
            (monad-qval monad-input))
    (apply values monad-input)))

(define identity-monad
  (lambda monad-input (apply values monad-input)))

(define (maybe-monad predicate)
  (lambda monad-input
    (let ((arg ((monad-arg monad-input))))
      (if (predicate arg)
          (monad-cret monad-input (const arg) identity)
          (monad-ret  monad-input (const arg))))))

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
        (let ((ret
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
                  (set! err args)))))
          (when normal? (finally-wraped))
          (when err (apply throw err))
          ret)))))

(define [with-bracket expr finally]
  "
  Applies `return' function to expr.
  `return' is a call/cc function, but it ensures that `finally' is called.
  Also, if exception is raised, `finally' executes.
  Composable, so that if bottom one calls `return', all `finally's are going to be called in correct order.
  Returns evaluated expr or re-throws an exception

  This is different from `with-bracket-dw' (dynamic-wind)
  because it executes `finally' before returning the control
  and it does not catch any non local jumps except the `return' and throws

  expr ::= ((Any -> Any) -> Any)
  finally ::= (-> Any)
  "
  (with-bracket-lf expr finally))

;;;;;;;;;;;;;;;;
;; STACK FLOW ;;
;;;;;;;;;;;;;;;;

;; get current stack
;; used for composition
;; DOES NOT UPDATE DURING `with-stack' EXECUTION
;; USED IN CALL
(define with-stack-stack (make-parameter (list)))

(define-rec stack-special-op
  type
  value)

(define [stack-apply stack proc]
  (let [[arity (procedure-get-minimum-arity proc)]]
    (append
     (call-with-values
         (lambda [] (apply proc (take stack arity)))
       (lambda vals (append vals stack))))))

(define [with-stack-full-loop initial operations]
  (let loop [[stack initial] [rest operations]]
    (if (null? rest)
        stack
        (let [[top (car rest)]]
          (cond
           [(procedure? top)
            (loop (stack-apply stack top) (cdr rest))]
           [(list? top)
            (loop stack (append top (cdr rest)))]
           [(stack-special-op? top)
            (let [[t (stack-special-op-type top)]]
              (cond
               [(eq? t 'eval) ;; interpret instruction from the stack
                (loop (cdr stack) (cons (car stack) (cdr rest)))]
               [(eq? t 'call)
                (parameterize [[with-stack-stack stack]]
                  (loop (stack-apply
                         stack
                         (stack-special-op-value top))
                        (cdr rest)))]
               [(eq? t 'whole) ;; passes whole stack to the function, expects new stack in return
                (loop
                 ((stack-special-op-value top) stack)
                 (cdr rest))]
               [(eq? t 'control) ;; like `whole' but also accepts and returns the `operations'
                (let-values
                    [[[new-stack new-ops]
                      ((stack-special-op-value top)
                       loop
                       stack
                       (cdr rest))]]
                  (loop new-stack new-ops))]
               [(eq? t 'escape) ;; like `control' but doesnt execute loop
                ((stack-special-op-value top)
                 loop
                 stack
                 (cdr rest))]
               [(eq? t 'push/cc)
                (loop
                 (stack-apply
                  stack
                  (lambda []
                    (case-lambda
                      [[vals] (loop (append vals stack) (cdr rest))] ;; only pushes values to the stack
                      [[vals ops] (loop (append vals stack) ops)]))) ;; also 'changes direction' by replacing `rest' by `ops'
                 (cdr rest))]
               [(eq? t 'call/cc)
                (parameterize [[with-stack-stack stack]]
                  ((stack-special-op-value top)
                   (lambda []
                     (case-lambda
                       [[vals] (loop (append vals stack) (cdr rest))] ;; only pushes values to the stack
                       [[vals ops] (loop (append vals stack) ops)] ;; also 'changes direction' by replacing `rest' by `ops'
                       ))))]))])))))

(define with-stack-full-loop-p
  (make-parameter with-stack-full-loop))

(define [with-stack-full initial operations]
  ((with-stack-full-loop-p) initial operations))

;; this is like `lambda' where `(with-stack-stack)' is the lexical/dynamic scope
(define [with-stack operations]
  (with-stack-full (with-stack-stack) operations))

(define-syntax-rule [PUSH x] (lambda [] x))
(define DROP
  (stack-special-op
   'whole
   cdr))

;; Like stack-apply but drops n elements from stack
;; where n=arity(f) or n is specified as first arg
(define USE
  (let ((retf
         (lambda (proc arity)
           (stack-special-op
            'whole
            (lambda (stack)
              (append
               (call-with-values
                   (lambda [] (apply proc (take stack arity)))
                 (lambda vals (append vals (drop stack arity))))))))))
    (case-lambda
      ((proc)
       (retf proc (procedure-get-minimum-arity proc)))
      ((arity proc)
       (retf proc arity)))))

(define [NULL] (values)) ;; useful for IF-THEN-ELSE
(define DUP identity)
(define [ADD a b] (+ a b))
(define [MUL a b] (* a b))
(define [NEGATE x] (- x))
(define [FLIP x y] (values y x)) ;; equivalent to (PERM 1 0)
(define [PERM . perms] ;; START WITH 0
  (stack-special-op
   'whole
   (lambda [stack]
     (append
      (map (lambda [pos] (list-ref stack pos))
            perms)
      stack))))

(define [CALL x] (stack-special-op 'call x)) ;; parameterizes call to `x'
(define EVAL (stack-special-op 'eval #f))
(define [IF-THEN-ELSE else then test]
  (if test
      then
      else))
(define (BOOL test then else)
  (IF-THEN-ELSE else then test))

(define PRINT
  (lambda [x] (printfln "~a" x) (values)))

(define [PRINTF fmt]
  (lambda [x] (printfln fmt x) (values)))

(define PUSH/CC (stack-special-op 'push/cc #f))
(define [CALL/CC f] (stack-special-op 'call/cc f))
(define [GOTO continuation . args]
  (stack-special-op
   'control
   (lambda [loop stack ops]
     (values ((continuation) args) (list)))))

(define [STACK-EFF environment-func]
  (stack-special-op
   'control
   (lambda [loop stack ops]
     (let [[ret
           (environment-func
            (lambda []
              (loop
               stack
               ops)))]]
       (if (stack-special-op? ret)
           (values (stack-special-op-type ret)
                   (stack-special-op-value ret))
           (values (list) (list)))))))

(define STACK-EFF-POP
  (stack-special-op
   'escape
   (lambda [loop stack ops]
     (stack-special-op stack ops))))

(define [MAP . funcs]
  "
   Maps functions on successive values from stack
   Stack must have enough elements"
  (let [[len (length funcs)]]
    (stack-special-op
     'whole
     (lambda [stack]
       (append
        (map (lambda [f x]
               (call-with-values
                   (lambda () (f x))
                 (lambda recv
                   (if (= (length recv) 1)
                       (car recv)
                       x))))
             funcs (take stack len))
        stack)))))

(define [PROJ . funcs]
  "Projects functions on stack top"
  (lambda [x]
    (apply values
           (map (lambda [f] (f x)) funcs))))

(define-syntax-rule (stack-lambda args . operations)
  (let [[arity (length (quote args))]]
    (stack-special-op
     'whole
     (lambda [stack]
       (let [[taken (take stack arity)]]
         (with-stack-full
          stack
          (apply
           (lambda args (list . operations))
           taken)))))))

(define-syntax-rule [define/stack [name . args] . operations]
  (define name (stack-lambda args . operations)))

;; naming..
(define my-global-scope-table-p (make-parameter (make-hash-table)))

;; this is like `fn'
(define [st-full . operations]
  (parameterize [[my-global-scope-table-p (make-hash-table)]]
    (with-stack operations)))

;; this is like `fn'
;; (define st (compose car st-full))
(define st (compose car st-full))

(define [PUT-symb name]
  (lambda [value]
    (hash-set! (my-global-scope-table-p) name value)
    (values)))

(define [STORE-symb name]
  (lambda [value]
    ((PUT-symb name) value)
    (values)))

(define [STORE/DEFAULT-symb name]
  (lambda [value]
    (let [[h (my-global-scope-table-p)]]
      (if (hash-has-key? h name)
          (hash-ref h name value)
          (begin
            (hash-set! h name value)
            value)))))

(define LOAD-symb
  (let [[unique (make-unique)]]
    (lambda [name]
      (lambda []
        (let [[ret (hash-ref (my-global-scope-table-p) name unique)]]
          (if (unique ret)
              (throw 'load-symb-invalid-name
                     `(args: ,name)
                     `(name does not exist in table))
              ret))))))

(define-syntax-rule [PUT name]
  (PUT-symb (quote name)))
(define-syntax-rule [STORE name]
  (STORE-symb (quote name)))
(define-syntax-rule [STORE/DEFAULT name]
  (STORE/DEFAULT-symb (quote name)))
(define-syntax-rule [LOAD name]
  (LOAD-symb (quote name)))

(define-syntax stackfn-coll
  (syntax-rules ()
    [(stackfn-coll buf body)
     (list (lambda buf body))]
    [(stackfn-coll buf x . xs)
     (cons
       (LOAD x)
       (stackfn-coll (x . buf) . xs))]))

(define-syntax-rule [stackfn . args]
  (stackfn-coll () . args))

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(define read-all-port
  (case-lambda
    ((readf port)
     "`readf' is usually `read-char' or `read-byte'"
     (let loop ((result '()) (chr (readf port)))
       (if (eof-object? chr)
           (list->string (reverse result))
           (loop (cons chr result) (readf port)))))
    ((port)
     (read-all-port read-char port))))

(define [read-string-file path]
  (let* [
   [in (open-file path "r")]
   [text (read-all-port read-char in)]
   (go (close-port in))]
   text))

(define [write-string-file path data]
  (let* [[out (open-file path "w")]
         [re (display data out)]
         (go (close-port out))]
    re))

(define [append-string-file path data]
  (let* [[out (open-file path "a")]
         [re (display data out)]
         (go (close-port out))]
    re))

(define [path-rebase newbase path]
  (let [[oldbase (take-common-prefix newbase path)]]
    (if (string-null? oldbase)
        #f
        (string-append newbase
                       (substring path
                                  (string-length oldbase))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NON PREEMPTIVE THREADS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-rec np-thread-obj
  continuation)

;; Disables critical zones because in non-interruptible mode
;; user can assure atomicity by themself
;; Locks still work as previusly,
;; but implementation must be changed,
;; because system mutexes will not allow to do yield
;; while waiting on mutex.
(define (np-thread-parameterize-env make-critical thunk)

  (define-values
      [np-thread-list-add
       np-thread-list-switch ;; pops thread from the top and sets `np-thread-current' = it
       np-thread-list-init
       np-thread-list-initialized?
       np-thread-list-remove
       np-thread-current
       ]
    (let* [[lst-p (make-parameter #f)]
           [critical (make-critical)]
           [current-thread (make-parameter #f)]]
      (values
       (lambda [th]
         (with-critical
          critical
          (set-box! (lst-p) (cons th (unbox (lst-p)))))
         th)
       (lambda []
         (with-critical
          critical
          (let* [[lst (unbox (lst-p))]
                 [head
                  (if (null? lst)
                      'np-thread-empty-list
                      (last lst))]]
            (unless (null? lst)
              (set-box! (lst-p) (list-init lst))
              (set-box! (current-thread) head))
            head)))
       (lambda [body]
         (parameterize [[lst-p (box (list))]
                        [current-thread (box (np-thread-obj body))]]
           (body)))
       (lambda []
         (if (lst-p) #t #f))
       (lambda [predicate]
         (with-critical
          critical
          (set-box! (lst-p)
                    (filter (negate predicate)
                            (unbox (lst-p))))))
       (lambda [] (unbox (current-thread))))))

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
    (let [[p (np-thread-list-switch)]]
      (if (eq? p 'np-thread-empty-list)
          ((np-thread-get-start-point))
          (begin
            ((np-thread-obj-continuation p) #t)
            (np-thread-end)))))

  (define [np-thread-yield]
    (when (np-thread-list-initialized?)
      (let* [[me (np-thread-current)]
             [repl (call/cc
                    (lambda [k]
                      (set-np-thread-obj-continuation! me k)
                      #f))]]
        (unless repl
          (np-thread-list-add me) ;; save
          (np-thread-end)))))

  (define [np-thread-fork thunk]
    (unless (np-thread-list-initialized?)
      (throw 'np-thread-forking-before-run!
             `(args: ,thunk)
             `(tried to fork np-thread before np-thread-run!)))

    (np-thread-list-add
     (np-thread-obj
      (lambda [tru]
        (thunk)
        (np-thread-end)))))

  (define-syntax-rule [np-thread-run! . thunk]
    (call/cc
     (lambda [k]
       (np-thread-set-start-point
        k
        (lambda []
          (begin . thunk)
          (np-thread-end))))))

  ;; Terminates np-thread
  ;; If no arguments given, current thread will be terminated
  ;; But if thread is provided, it will be removed from thread list (equivalent to termination if that thread is not the current one)
  ;; Therefore, don't provide current thread as argument unless you really mean to
  (define np-thread-cancel!
    (case-lambda
      [[]
       (np-thread-end)]
      [[chosen]
       (np-thread-list-remove (lambda [th] (eq? th chosen)))]))

  (define [np-thread-cancel-all!]
    "
  Terminates all threads on current thread group
  "
    (np-thread-list-remove (const #t))
    (np-thread-end))

  (parameterize ((dynamic-thread-spawn-p np-thread-fork)
                 (dynamic-thread-cancel-p np-thread-cancel!)
                 (dynamic-thread-yield-p np-thread-yield)
                 (dynamic-thread-sleep-p universal-usleep)
                 (dynamic-thread-mutex-make-p make-unique)
                 (dynamic-thread-mutex-lock!-p universal-lockr!)
                 (dynamic-thread-mutex-unlock!-p universal-unlockr!)
                 (dynamic-thread-critical-make-p
                  (lambda ()
                    (lambda (fn) (fn)))))
    (np-thread-run! (thunk))))

(define-syntax-rule (with-np-thread-env#non-interruptible . bodies)
  (np-thread-parameterize-env (lambda () (lambda (fn) (fn)))
                              (lambda () . bodies)))

;;;;;;;;;;;;;;;
;; PROCESSES ;;
;;;;;;;;;;;;;;;

(define [kill-comprocess-with-timeout p timeout]
  (unless (comprocess-exited? p)
    (kill-comprocess p #f)
    (unless (comprocess-exited? p)
      (call-with-new-sys-thread
       (lambda []
         (usleep timeout)
         (unless (comprocess-exited? p)
           (kill-comprocess p #t)))))))

;;;;;;;;;;;;;;;;;;;;;;;
;; GENERIC FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;

(begin-for-syntax
 (define-syntax-rule [generate-add-name name]
   (generate-prefixed-name 'gfunc/instantiate- name))

 (define-syntax-rule [generate-param-name name]
   (generate-prefixed-name 'gfunc/parameterize- name)))

(define [check-list-contract check-list args]
  (or (not check-list)
      (and (= (length check-list) (length args))
           (fold (lambda [p x c] (and c (p x))) #t check-list args))))

(define-syntax gfunc/define
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/define name]
       (with-syntax ([add-name (generate-add-name #'name)]
                     [param-name (generate-param-name #'name)])
         #'(define-values [name add-name param-name]
             (let [[internal-list (make-parameter '())]
                   [critical (dynamic-thread-critical-make)]]
               (values
                (lambda args
                  (let [[m (find-first (lambda [p] (check-list-contract (car p) args)) (internal-list))]]
                    (if m
                        (apply (cdr m) args)
                        (throw 'gfunc-no-instance-found
                               (string-append "No gfunc instance of "
                                              (symbol->string (syntax->datum #'name))
                                              " accepts required arguments")))))
                (lambda [args func]
                  (with-critical
                   critical
                   (set! internal-list
                     (make-parameter (append (internal-list)
                                             (list (cons args
                                                         func)))))))
                (lambda [args func body]
                  (let [[new-list (cons (cons args func) (internal-list))]]
                    (parameterize [[internal-list new-list]]
                      (body))))))))])))

(define-syntax gfunc/parameterize
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/parameterize name check-list func . body]
       (with-syntax [[param-name (generate-param-name #'name)]]
         #'(param-name check-list func (lambda [] . body)))])))

(define-syntax gfunc/instance
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/instance name check-list func]
       (with-syntax [[add-name (generate-add-name #'name)]]
         #'(add-name (list . check-list) func))])))

;;;;;;;;;;;;;
;; SCRIPTS ;;
;;;;;;;;;;;;;

(define (shell-check-status p)
  (unless (= 0 (comprocess-status p))
    (throw 'shell-process-failed `(cmd: ,(comprocess-command p)) p)))

(define [sh-async-no-log cmd]
  (run-comprocess "/bin/sh" "-c" cmd))

(define (sh-async cmd)
  (monadic-id
   (ret (sh-async-no-log cmd))
   (do (printfln "> ~a" cmd) `(log ,cmd in shell))
   ret))

(define [sh cmd]
  (monadic-id
   (p (sh-async cmd))
   (do (sleep-until (comprocess-exited? p)))
   (do (shell-check-status p))
   p))

(define [sh-re cmd]
  (monadic (except-monad)
   ((outport outfilename) (make-temporary-fileport))
   (p (run-comprocess#full outport outport "/bin/sh" "-c" cmd))
   (do (printfln "> ~a" cmd) `(log ,cmd in shell))
   (do (sleep-until (comprocess-exited? p)))
   (do (shell-check-status p))
   (ret (read-string-file outfilename))
   (trimed (string-trim-chars ret "\n \t" 'both))
   (do (printfln "< ~a" trimed) `(log ,cmd in shell) 'sh-re-return)
   (do (close-port outport) 'always)
   (do (delete-file outfilename) 'always)
   trimed))

(define (system-re command)
  "Like `system', but returns (output, exit status)"
  (monadic-id
   (temp (make-temporary-filename))
   (p (system*/exit-code "/bin/sh" "-c"
                         (string-append command " > " temp)))
   (output (read-string-file temp))
   (trimed (string-trim-chars output "\n \t" 'both))
   (cons trimed p)))

(define (parse-cli args)
  (define (trim s) (string-trim-chars s "-" 'left))

  (let lp ((pos 0) (buf (list (cons #f #t))) (left args))
    (if (null? left)
        buf
        (let ((current (car left)))
          (cond
           ((string-startswith? current "-")
            (let* ((key (trim current))
                   (cell (cons key #t))
                   (rest (cdr left)))
              (lp pos (cons cell buf) rest)))
           (#t
            (lp (1+ pos) (cons (cons pos current) buf) (cdr left))))))))

(define parse-cli-global-p (make-parameter #f))
(define parse-cli-global-default
  (let ((value #f))
    (case-lambda
      (() value)
      ((new-value)
       (set! value new-value)
       new-value))))

(define (parse-cli!)
  (let ((parsed (parse-cli (get-command-line-arguments))))
    (parse-cli-global-default parsed)
    parsed))
(define (parse-cli-parse-or-get!)
  (if (parse-cli-global-p)
      (parse-cli-global-p)
      (if (parse-cli-global-default)
          (parse-cli-global-default)
          (parse-cli!))))

(define (parse-cli-get-flag key)
  (let* ((parsed (parse-cli-parse-or-get!))
         (ret (assoc key parsed)))
    (if (pair? ret)
        (cdr ret)
        ret)))

(define (parse-cli-get-switch key)
  (let ((parsed (parse-cli-parse-or-get!)))
    (let lp ((rest parsed) (prev #f))
      (if (null? rest)
          (throw 'missing-command-line-switch-value key)
          (let* ((current (car rest))
                 (k (car current))
                 (v (cdr current)))
            (if (equal? k key)
                (if prev prev
                    (throw 'command-line-flag-should-be-a-switch
                           key))
                (lp (cdr rest) v)))))))

(define (parse-cli-get-list after-key)
  (let* ((parsed (parse-cli-parse-or-get!)))
    (let lp ((rest (reverse parsed))
             (found? #f))
      (if (null? rest)
          (if found?
              (list)
              found?)
          (let ((key (car (car rest)))
                (val (cdr (car rest))))
            (if found?
                (if (integer? key)
                    (cons val (lp (cdr rest) found?))
                    (list)) ; NOTE: next is another flag/switch
                (if (equal? key after-key)
                    (lp (cdr rest) (not found?))
                    (lp (cdr rest) found?))))))))


;;;;;;;;;;;;;;;;;;
;; TREE-FUTURES ;;
;;;;;;;;;;;;;;;;;;

;; Futures, but
;; * form trees
;;   Tree-future is finished when its body is evaluated
;;   and all of its children are finished
;; * multiplatform
;;   Supports different threading models
;;   Depends on abstract implementation
;;   of critical-make, thread-spawn, etc
;; * cancellable
;;   Can be intrrupted at any moment
;;   Root is cancelled first then its nodes
;;   May not be supported by threading model
;; * stateful
;;   Provides functionality to modify
;;   future-local state.
;;   Mutations are atomic

(define-rec tree-future
  parent-index
  current-index
  children-list
  callback ;; (: tree-future -> result -> exit-code -> a) called on finish or on exception or if cancelled; if exception happend, some children may not be finished yet; it is safe to modify this structure after callback is called
  thread ;; running thread.  On normal exit, callback is also called on this thread, but if this cancelled, then callback is called on a newly created thread
  finished? ;; used for callback scheduling.  On normal exit (with or without error) `finished?` is #t, but when cancelled, `finished` is #f
  context ;; thunk that evaluates contexts and returns it.  #memoized
  )

(define tree-future-current (make-parameter #f))
(define tree-future-eval-context-p (make-parameter #f))
(define (tree-future-eval-context) ((tree-future-eval-context-p)))

;; Initializes tree-future env using current threading model
;; Returns an interface for this environment
(define (tree-future-get)
  (let*
      ((message-bin null) ;; TODO: replace by atomic queue
       (message-bin-lock (dynamic-thread-critical-make))

       (init-lock (dynamic-thread-critical-make))
       (work-thread #f)

       (futures-hash (make-hash-table))
       (get-by-index
        (lambda (index)
          (hash-ref futures-hash index #f)))

       (wait-all
        (lambda ()
          (sleep-until (not work-thread))))

       (logger
        (lambda (fmt . args)
          (apply printfln (cons fmt args))))

       (send-message
        (lambda type-args
          (with-critical
           message-bin-lock
           (set! message-bin
             (cons type-args message-bin)))))

       (remove-future-sync
        (lambda (structure set-finished?)
          (when (and-map (lambda (child-index) (not (get-by-index child-index)))
                         (tree-future-children-list structure))
            (hash-remove! futures-hash (tree-future-current-index structure))
            (when set-finished?
              (set-tree-future-finished?! structure #t))
            (send-message
             'remove
             (tree-future-parent-index structure)))))

       (dispatch
        (lambda (type . args)
          (case type
            ((start)
             (match args
               (`(,parent-index
                  ,current-index
                  ,target-procedure
                  ,callback
                  ,initial-context)
                (if (get-by-index current-index)
                    (logger "index already exists")
                    (let* ((parent (get-by-index parent-index))
                           (context (lambda () initial-context))
                           (structure (tree-future parent-index
                                                   current-index
                                                   null
                                                   callback
                                                   #f
                                                   #f
                                                   context))
                           (eval-context
                            (lambda () ((tree-future-context structure))))
                           (finish (lambda ()
                                     (send-message 'remove current-index)
                                     (printfln "WAITING FOR FINISHED?")
                                     (sleep-until (tree-future-finished? structure)))))
                      (hash-set! futures-hash current-index structure)
                      (when parent
                        (set-tree-future-children-list!
                         parent
                         (cons current-index
                               (tree-future-children-list parent))))
                      (set-tree-future-thread!
                       structure
                       (dynamic-thread-spawn
                        (lambda ()
                          (parameterize ((tree-future-current current-index)
                                         (tree-future-eval-context-p eval-context))
                            (catch-any
                             (lambda ()
                               (let ((result (target-procedure)))
                                 (finish)
                                 (callback structure result 'ok)))
                             (lambda err
                               (finish)
                               (callback structure err 'error))))))))))
               (else
                (logger "wrong number of arguments to 'start"))))

            ((remove)
             (printfln "REMOVING")

             (match args
               (`(,index)
                (let* ((structure (get-by-index index)))
                  (when structure
                    (remove-future-sync structure #t))))
               (else
                (logger "wrong number of arguments to 'remove"))))

            ((cancel)
             (printfln "CANCEL")

             (match args
               (`(,index ,argument)
                (let* ((structure (get-by-index index)))
                  (if structure
                      (unless (tree-future-finished? structure) ;; NOTE: do not cancel callback!
                        (dynamic-thread-cancel (tree-future-thread structure))
                        (remove-future-sync structure #f) ;; NOTE: removes but callback will not be called
                        (dynamic-thread-spawn
                         (lambda ()
                           ((tree-future-callback structure) structure argument 'cancel))))
                      (logger "bad index"))))
               (else
                (logger "wrong number of arguments to 'remove"))))

            ((context) ;; also used for checking if future exists
             (printfln "CONTEXT")
             (match args
               (`(,target-index ,transformer ,error-handler)
                (let ((target (get-by-index target-index)))
                  (if target
                      (let ((current (tree-future-context target)))
                        (set-tree-future-context!
                         target
                         (let ((saved? #f)
                               (memory #f))
                           (lambda ()
                             (unless saved?
                               (set! saved? #t)
                               (set! memory (transformer (current))))
                             memory))))
                      (error-handler 'doesnt-exist))))
               (else
                (logger "wrong number of arguments to 'context")))))))

       (recieve-loop
        (lambda ()
          (let ((sleep (dynamic-thread-sleep-p)))
            (let lp ()
              (let ((val null))
                (with-critical
                 message-bin-lock
                 (begin
                   (set! val message-bin)
                   (set! message-bin null)))
                (for-each
                 (lambda (elem)
                   (apply dispatch elem))
                 (reverse val)))
              (if (hash-empty? futures-hash)
                  (set! work-thread #f)
                  (begin
                    (sleep 100)
                    (lp)))))))

       (maybe-start-loopin
        (lambda ()
          (init-lock
           (lambda ()
             (unless work-thread
               (set! work-thread
                 (dynamic-thread-spawn recieve-loop)))))))

       (run (lambda (target-procedure
                     callback
                     initial-context)
              (let ((current-index (tree-future-current))
                    (target-index (make-unique)))
                (send-message 'start
                              current-index
                              target-index
                              target-procedure
                              callback
                              initial-context)
                (maybe-start-loopin)
                target-index)))

       (modify
        (lambda (target-index transformation)
          (send-message 'context
                        target-index
                        transformation
                        (lambda (error)
                          (logger "bad index")))))
       )
    (values run modify wait-all)))

(define tree-future-run-p (make-parameter #f))
(define (tree-future-run . args)
  (apply (tree-future-run-p) args))

(define tree-future-modify-p (make-parameter #f))
(define (tree-future-modify . args)
  (apply (tree-future-modify-p) args))

(define-syntax-rule (with-new-tree-future-env . bodies)
  (let-values (((run modify wait) (tree-future-get)))
    (parameterize ((tree-future-run-p run)
                   (tree-future-modify-p modify))
      (with-bracket
       (lambda (return)
         (begin . bodies))
       (lambda args
         (wait))))))

