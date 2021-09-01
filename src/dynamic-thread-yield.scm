
%run guile

%var dynamic-thread-yield

%use (dynamic-thread-yield#p) "./dynamic-thread-yield-p.scm"
%use (dynamic-thread-yield#p-default) "./dynamic-thread-yield-p-default.scm"

(define (dynamic-thread-yield)
  ((or (dynamic-thread-yield#p)
       dynamic-thread-yield#p-default)))
