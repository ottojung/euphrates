


;; This is like futures.
;; Use this when need to join a thread.

(define (dynamic-thread-async-thunk thunk)
  (define status #f) ;; \in { #f, 'ok, 'fail }
  (define results #f)
  (define lock (dynamic-thread-mutex-make))
  (define thread
    (begin
      (dynamic-thread-mutex-lock! lock)
      (dynamic-thread-spawn
       (lambda ()
         (catch-any
          (lambda ()
            (call-with-values thunk
              (lambda vals
                (set! results vals)
                (set! status 'ok)
                (dynamic-thread-mutex-unlock! lock))))
          (lambda errors
            (set! results errors)
            (set! status 'fail)
            (dynamic-thread-mutex-unlock! lock)))))))

  (define (wait/no-throw)
    (dynamic-thread-mutex-lock! lock)
    (dynamic-thread-mutex-unlock! lock))

  (define (wait)
    (wait/no-throw)
    (when (eq? 'fail status)
      (raisu 'dynamic-thread-run-async-failed results))
    (apply values results))

  (case-lambda
   (() (wait))
   ((operation)
    (case operation
      ((wait) (wait))
      ((wait/no-throw) (wait/no-throw))
      ((thread) thread)
      ((status) status)
      ((results) results)))))
