
%run guile

%use (dynamic-thread-yield#p) "./dynamic-thread-yield-p.scm"

%var dynamic-thread-get-yield-procedure

(define (dynamic-thread-get-yield-procedure)
  (dynamic-thread-yield#p))

