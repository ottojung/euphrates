
%run guile

%use (dynamic-thread-get-delay-procedure#p) "./dynamic-thread-get-delay-procedure-p.scm"
%use (dynamic-thread-get-delay-procedure#p-default) "./dynamic-thread-get-delay-procedure-p-default.scm"

%var dynamic-thread-get-delay-procedure

(define (dynamic-thread-get-delay-procedure)
  (let ((p (dynamic-thread-get-delay-procedure#p)))
    (if p (p)
        (dynamic-thread-get-delay-procedure#p-default))))
