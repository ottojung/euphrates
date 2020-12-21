
%run guile

%var sleep-until

(define-syntax-rule [sleep-until condi . body]
  (let ((sleep (dynamic-thread-get-delay-procedure)))
    (do ()
        (condi)
      (sleep)
      . body)))
