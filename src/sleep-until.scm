
%run guile

%var sleep-until

%use (dynamic-thread-get-delay-procedure) "./dynamic-thread-get-delay-procedure.scm"

(define-syntax-rule [sleep-until condi . body]
  (let ((sleep (dynamic-thread-get-delay-procedure)))
    (do ()
        (condi)
      (sleep)
      . body)))
