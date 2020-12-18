
%run guile

%use (dynamic-thread-sleep#p) "./dynamic-thread-sleep.scm"
%use (dynamic-thread-wait-delay#us#p) "./dynamic-thread-wait-delay.scm"

%var dynamic-thread-get-delay-procedure#p-default

(define (dynamic-thread-get-delay-procedure#p-default)
  (let ((sleep (dynamic-thread-sleep#p))
        (timeout (dynamic-thread-wait-delay#us#p)))
    (lambda ()
      (sleep timeout))))
