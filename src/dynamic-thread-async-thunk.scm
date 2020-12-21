
%run guile

%use (dynamic-thread-spawn) "./dynamic-thread-spawn.scm"
%use (catch-any) "./catch-any.scm"
%use (sleep-until) "./sleep-until.scm"

%var dynamic-thread-async-thunk

(define (dynamic-thread-async-thunk thunk)
  (let ((results #f)
        (status #f)) ;; \in { #f, 'ok, 'fail }

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
          (set! status 'fail)))))

    (lambda ()
      (sleep-until status)
      (when (eq? 'fail status)
        (throw 'dynamic-thread-run-async-failed results))
      (apply values results))))
