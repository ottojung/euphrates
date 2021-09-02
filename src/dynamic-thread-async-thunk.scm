
%run guile

%use (dynamic-thread-spawn) "./dynamic-thread-spawn.scm"
%use (catch-any) "./catch-any.scm"
%use (sleep-until) "./sleep-until.scm"
%use (raisu) "./raisu.scm"

;; This is like futures.
;; Use this when need to join a thread.
%var dynamic-thread-async-thunk

(define (dynamic-thread-async-thunk thunk)
  (define status #f) ;; \in { #f, 'ok, 'fail }
  (define results #f)
  (define thread
    (dynamic-thread-spawn
     (lambda ()
       (catch-any
        (lambda ()
          (call-with-values thunk
            (lambda vals
              (set! results vals)
              (set! status 'ok))))
        (lambda errors
          (set! results errors)
          (set! status 'fail))))))

  (define (wait/no-throw)
    (sleep-until status))

  (define (wait)
    (sleep-until status)
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
