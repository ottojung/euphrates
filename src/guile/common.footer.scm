;;;;;;;;;;;;;;;;;;;;
;; HASHED RECORDS ;;
;;;;;;;;;;;;;;;;;;;;

(define [alist->hash-table lst]
  (let [[h (make-hash-table)]]
    (for-each
     (lambda (pair)
       (hash-set! h (car pair) (cdr pair)))
     lst)
    h))

(define [hash->mdict h]
  (letin
   [unique (make-unique)]
   (make-procedure-with-setter
    (lambda [key]
      (let [[g (hash-ref h key unique)]]
        (if (unique g)
            (throw 'mdict-key-not-found key h)
            g)))
    (lambda [new] h))))

(define [alist->mdict alist]
  (hash->mdict (alist->hash-table alist)))

(define-syntax mdict-c
  (syntax-rules ()
    [(mdict-c carry) (alist->mdict carry)]
    [(mdict-c carry key value . rest)
     (mdict-c (cons (cons key value) carry) . rest)]))

(define-syntax-rule [mdict . entries]
  (mdict-c '() . entries))

(define [mdict-has? h-func key]
  (let [[h (set! (h-func) 0)]]
    (hash-get-handle h key)))

(define [mdict->alist h-func]
  (let [[h (set! (h-func) 0)]]
    (hash-map->list cons h)))

(define [mass *mdict key value]
  (let* [[new (alist->hash-table (mdict->alist *mdict))]
         [new-f (hash->mdict new)]
         (do (hash-set! new key value))]
    new-f))

(define [mdict-keys h-func]
  (map car (mdict->alist h-func)))

;;;;;;;;;;;;;;;;;;;;;;;;
;; PREEMPTIVE THREADS ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Enable asynchronous auto-yield
;; making non-preemptive threads to preemptive ones (or `i-thread's - "interuptible threads")
;;
;; NOTE:
;; * `dynamic-thread-mutex-lock!' is not interruptible
;;   Use `i-thread-critical!' to ensure that no interrupt will happen before `dynamic-thread-mutex-unlock!'
;;   Or use `universal-lockr' and `universal-unlockr' instead
;; * `sleep' (`usleep') is not interruptible
;;   use `universal-usleep' instead

;; TODO: [variable interrupt frequency] use this somehow
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
                dynamic-thread-yield
                th))
             lst)
            (usleep 900000) ;; TODO: [variable interrupt frequency]
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

(define [i-thread-dont-yield-me]
  (i-thread-dont-yield ((@ [ice-9 threads] current-thread))))

(define-syntax-rule [i-thread-run! . thunk]
  (dynamic-wind
    i-thread-yield-me
    (lambda [] (begin . thunk))
    i-thread-dont-yield-me))

;; For debug purposes
(define-values
  [i-thread-critical-points
   i-thread-critical-points-append!
   i-thread-critical-points-remove!
   i-thread-critical-points-print]
  (let [[lst (list)]
        [mut (make-uni-spinlock-critical)]]
    (values
     (lambda [] lst)
     (lambda [st]
       (with-critical
        mut
        (set! lst (cons st lst))))
     (lambda [st]
       (with-critical
        mut
        (set! lst
          (filter (lambda [el] (not (equal? el st)))
                  lst))))
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

;; Critical zones relaxed - they don't need mutexes
;; but they do need to be disabled from interrupts
;; Locks still work as previusly,
;; but implementation must be changed,
;; because system mutexes will not allow to do yield
;; while waiting on mutex. Locks are the same as for np-thread
(define (i-thread-parameterize-env#interruptible thunk)
  (parameterize ((dynamic-thread-critical-make-p
                  (lambda ()
                    (lambda (fn)
                      (i-thread-critical! (fn)))))
                 (dynamic-thread-mutex-make-p make-unique)
                 (dynamic-thread-mutex-lock!-p universal-lockr!)
                 (dynamic-thread-mutex-unlock!-p universal-unlockr!))
    (i-thread-run! (thunk))))

(define-syntax-rule (with-i-thread-env#interruptible . bodies)
  (i-thread-parameterize-env#interruptible
   (lambda () . bodies)))
