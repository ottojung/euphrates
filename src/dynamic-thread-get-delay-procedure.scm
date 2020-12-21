
%run guile

%use (dynamic-thread-get-delay-procedure#p-default) "./dynamic-thread-get-delay-procedure-default.scm"

%var dynamic-thread-get-delay-procedure#p
%var dynamic-thread-get-delay-procedure

(define dynamic-thread-get-delay-procedure#p
  (make-parameter dynamic-thread-get-delay-procedure#p-default))
(define (dynamic-thread-get-delay-procedure)
  ((dynamic-thread-get-delay-procedure#p)))

