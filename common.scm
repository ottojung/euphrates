(define-module [my-guile-std common]
  :export
  [
   dom-print
   gfunc/define
   gfunc/instance
   gfunc/parameterize
   printf
   println
   global-debug-mode-filter
   debug
   stringf
   time-to-nanoseconds
   time-get-monotonic-timestamp
   read-file
   write-file
   np-thread-fork
   np-thread-yield
   np-thread-start
   np-thread-sleep-rate-ms
   np-thread-sleep-rate-ms-set!
   np-thread-usleep
   np-thread-cancel!
   np-thread-cancel-all!
   i-thread-yield
   i-thread-yield-me
   i-thread-start
   i-thread-critical!
   i-thread-critical-b!
   i-thread-critical-points
   i-thread-critical-points-print
   ]

  :re-export
  [
   letin
   defloop
   apploop
   reversed-args
   fn
   fn-list
   with-return
   monoids*
   monoids-r*
   monoid-r*
   monoid*
   letin-with-full
   letin-parameterize
   letin-with-full-parameterized
   letin-with
   letin-with-identity
   dom
   domid
   domf
   dom-default
   range
   list-init
   second-to-microsecond
   microsecond-to-nanosecond
   second-to-nanosecond
   nanosecond-to-microsecond
   generate-prefixed-name
   with-bracket
   with-bracket-dw
   mdict
   mdict?
   mass
   mdict-has?
   mdict-keys
   ]

  :use-module [my-guile-std pure]
  :use-module [ice-9 format]
  :use-module [ice-9 textual-ports]
  :use-module [srfi srfi-1]
  :use-module [srfi srfi-13]
  :use-module [ice-9 hash-table]
  :use-module [ice-9 threads]
  :use-module [srfi srfi-18]
  :use-module [srfi srfi-42]
  :use-module [srfi srfi-16]
  :use-module [srfi srfi-19] ;; time
  :use-module [srfi srfi-111] ;; box
  )

;;;;;;;;;;;;;;;;
;; SHORTHANDS ;;
;;;;;;;;;;;;;;;;

(define my-make-mutex (@ (srfi srfi-18) make-mutex))

(define-syntax-rule [stringf fmt . args]
  (with-output-to-string
    (lambda []
      (format #t fmt . args))))

(define local-print
  (let [[mu (my-make-mutex)]]
    (lambda [s]
      (call-with-blocked-asyncs
       (lambda []
         (let [[err #f]]
           (mutex-lock! mu)
           (catch #t
             (lambda []
               (display s))
             (lambda argv
               (set! err argv)))
           (mutex-unlock! mu)
           (when err (apply throw err))))))))

(define-syntax-rule [printf fmt . args]
  (local-print (stringf fmt . args)))

(define-syntax-rule [println fmt . args]
  (printf (string-append fmt "\n") . args))

(define global-debug-mode-filter (make-parameter #f))

(define-syntax-rule [debug fmt . args]
  (let [[p (global-debug-mode-filter)]]
    (when (or (not p) (and p (p fmt (list . args))))
      (printf fmt . args))))

;; Logs computations
(define [dom-print name result x cont]
  (format #t "(~a = ~a = ~a)\n" name x result)
  (cont x))

(define [time-get-monotonic-timestamp]
  (time-to-nanoseconds ((@ (srfi srfi-19) current-time) time-monotonic)))

(define [time-to-nanoseconds time]
  (+ (time-nanosecond time) (* 1000000000 (time-second time))))

;;;;;;;;;;;;;;;;;;;;;;;
;; GENERIC FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;

(define [check-list-contract check-list args]
  (or (not check-list)
      (and (= (length check-list) (length args))
           (fold (lambda [p x c] (and c (p x))) #t check-list args))))

(define-syntax-rule [generate-add-name name]
  (generate-prefixed-name 'gfunc/instantiate- name))

(define-syntax-rule [generate-param-name name]
  (generate-prefixed-name 'gfunc/parameterize- name))

(define-syntax gfunc/define
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/define name]
       (with-syntax ([add-name (generate-add-name name)]
                     [param-name (generate-param-name name)])
         #'(define-values [name add-name param-name]
             (let [[internal-list (make-parameter '())]
                   [sem (my-make-mutex)]]
               (values
                (lambda args
                  (let [[m (find (lambda [p] (check-list-contract (car p) args)) (internal-list))]]
                    (if m
                        (apply (cdr m) args)
                        (throw 'gfunc-no-instance-found
                               (string-append "No gfunc instance of "
                                              (symbol->string (syntax->datum #'name))
                                              " accepts required arguments")))))
                (lambda [args func]
                  (call-with-blocked-asyncs
                   (lambda []
                     (mutex-lock! sem)
                     (set! internal-list (make-parameter (append (internal-list) (list (cons args func)))))
                     (mutex-unlock! sem))))
                (lambda [args func body]
                  (let [[new-list (cons (cons args func) (internal-list))]]
                    (parameterize [[internal-list new-list]]
                      (body))))))))])))

(define-syntax gfunc/parameterize
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/parameterize name check-list func . body]
       (with-syntax [[param-name (generate-param-name name)]]
         #'(param-name check-list func (lambda [] . body)))])))

(define-syntax gfunc/instance
  (lambda (stx)
    (syntax-case stx ()
      [[gfunc/instance name check-list func]
       (with-syntax [[add-name (generate-add-name name)]]
         #'(add-name (list . check-list) func))])))

;;;;;;;;;;;;;
;; FILE IO ;;
;;;;;;;;;;;;;

(define* [read-file path #:optional [mode 'r]]
  (letin-with-identity
   [in (open-file path (~a mode))]
   [text (get-string-all in)]
   (do (close-port in))
   text))

(define* [write-file path data #:optional [fmt "~a"] [mode 'w]]
  "mode ::= 'w | 'a"
  (letin-with-identity
   [out (open-file path (~a mode))]
   [re (format out fmt data)]
   (do (close-port out))
   re))

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
         [mut (my-make-mutex)]
         [with-lock
          (lambda [thunk]
            (call-with-blocked-asyncs
             (lambda []
               (mutex-lock! mut)
               (let [[ret (thunk)]]
                 (mutex-unlock! mut)
                 ret))))]]
    (values
     (lambda [th]
       (with-lock
        (lambda []
          (set-box! (lst-p) (cons th (unbox (lst-p)))))))
     (lambda []
       (with-lock
        (lambda []
          (let* [[lst (unbox (lst-p))]
                 [head
                  (if (null? lst)
                      'np-thread-empty-list
                      (last lst))]]
            (unless (null? lst)
              (set-box! (lst-p) (list-init lst)))
            head))))
     (lambda [body]
       (parameterize [[lst-p (box (list))]]
         (body)))
     (lambda []
       (if (lst-p) #t #f))
     (lambda [predicate]
       (with-lock
        (lambda []
          (set-box! (lst-p)
                    (filter (negate predicate)
                            (unbox (lst-p))))))))))

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
  (np-thread-list-add
   (lambda [tru]
     (thunk)
     (np-thread-end))))

(define [np-thread-start thunk]
  (call/cc
   (lambda [k]
     (np-thread-set-start-point
      k
      (lambda []
       (thunk)
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
         [start-time (time-get-monotonic-timestamp)]
         [end-time (+ start-time nano-seconds)]
         [sleep-rate (np-thread-sleep-rate-ms)]]
    (letrec
        [[lapse
          (lambda []
            (let* [[t (time-get-monotonic-timestamp)]]
              (unless (> t end-time)
                (let [[s (min sleep-rate
                              (nanosecond-to-microsecond (- end-time t)))]]
                  (np-thread-yield)
                  (usleep s)
                  (lapse)))))]]
      (lapse))))

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

;;;;;;;;;;;;;;;;;;;;;;;;
;; PREEMPTIVE THREADS ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable asynchronous auto-yield
;; making non-preemptive threads to preemptive ones (or `i-thread's - "interuptible threads")
;;
;; NOTE:
;; * `mutex-lock!' is not interruptible
;;   Use `i-thread-critical!' to ensure that no interrupt will happen before `mutex-unlock!'
;; * `sleep' (`usleep') is not interruptible
;;   use `np-thread-usleep' instead

(define global-interrupt-frequency-p (make-parameter 1000000))

(define-values
  [i-thread-yield
   i-thread-dont-yield]
  (let [[interruptor-thread #f]
        [lst (list)]
        [interruptor-finished? #t]]

    (define [interruptor-loop]
      (if (null? lst)
          (set! interruptor-finished? #t)
          (begin
            (map
             (lambda [th]
               (system-async-mark
                np-thread-yield
                th))
             lst)
            (usleep 900000)
            (interruptor-loop))))

    (values
     (lambda [thread]

       (when interruptor-finished?
         (set! interruptor-thread
           (call-with-new-thread interruptor-loop)))

       (system-async-mark
        (lambda []
          (unless (member thread lst)
            (set! lst (cons thread lst))))
        interruptor-thread))

     (lambda [thread]
       (unless interruptor-finished?
         (system-async-mark
          (lambda []
            (set! lst
              (filter (lambda [th] (not (equal? th thread)))
                      lst)))
          interruptor-thread))))))

(define [i-thread-yield-me]
  (i-thread-yield ((@ [ice-9 threads] current-thread))))

(define [i-thread-start thunk]
  (np-thread-start
   (lambda []
     (i-thread-yield-me)
     (thunk))))

;; For debug purposes
(define-values
  [i-thread-critical-points
   i-thread-critical-points-append!
   i-thread-critical-points-remove!
   i-thread-critical-points-print]
  (let [[lst (list)]
        [mut (my-make-mutex)]]
    (values
     (lambda [] lst)
     (lambda [st]
       (mutex-lock! mut)
       (set! lst (cons st lst))
       (mutex-unlock! mut))
     (lambda [st]
       (mutex-lock! mut)
       (set! lst
         (filter (lambda [el] (not (equal? el st)))
                 lst))
       (mutex-unlock! mut))
     (lambda []
       (format #t "--- CRITICAL POINTS ---\n")
       (for-each
        (lambda [st]
          (display-backtrace st (current-output-port)))
        lst)
       (format #t "--- END CRITICAL POINTS ---\n")))))

(define-syntax-rule [i-thread-critical! . thunk]
  "
  Will not interrupt during execution of `thunk'
  Unsafe: must finish quick!
  "
  (call-with-blocked-asyncs
   (lambda []
     (let [[st (make-stack #t)]]
       (i-thread-critical-points-append! st)
       (begin . thunk)
       (i-thread-critical-points-remove! st)))))

(define [i-thread-critical-b! thunk finally]
  "
  Same as `i-thread-critical' but also puts `thunk' and `finally' to `with-bracket' clause
  "
  (i-thread-critical! (with-bracket thunk finally)))

