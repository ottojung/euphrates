
%run guile

%use (dynamic-thread-sleep#p) "./dynamic-thread-sleep-p.scm"
%use (dynamic-thread-sleep) "./dynamic-thread-sleep.scm"
%use (dynamic-thread-get-wait-delay) "./dynamic-thread-get-wait-delay.scm"

%var dynamic-thread-get-delay-procedure#p-default

(define (dynamic-thread-get-delay-procedure#p-default)
  (let ((timeout (dynamic-thread-get-wait-delay))
        (sleep (or (dynamic-thread-sleep#p) dynamic-thread-sleep)))
    (lambda _
      (sleep timeout))))
