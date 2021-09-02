
%run guile

%use (dynamic-thread-sleep#p) "./dynamic-thread-sleep-p.scm"
%use (dynamic-thread-get-wait-delay) "./dynamic-thread-get-wait-delay.scm"

%var dynamic-thread-get-delay-procedure#p-default

(define (dynamic-thread-get-delay-procedure#p-default)
  (let ((sleep (dynamic-thread-sleep#p))
        (timeout (dynamic-thread-get-wait-delay)))
    (lambda ()
      (sleep timeout))))
