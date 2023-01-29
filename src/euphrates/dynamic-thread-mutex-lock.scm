
%run guile

%var dynamic-thread-mutex-lock!

%use (dynamic-thread-mutex-lock!#p) "./dynamic-thread-mutex-lock-p.scm"
%use (dynamic-thread-mutex-lock!#p-default) "./dynamic-thread-mutex-lock-p-default.scm"

(define (dynamic-thread-mutex-lock! mut)
  ((or (dynamic-thread-mutex-lock!#p)
       dynamic-thread-mutex-lock!#p-default) mut))
