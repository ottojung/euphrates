

%run guile

%var dynamic-thread-mutex-make

%use (dynamic-thread-mutex-make#p) "./dynamic-thread-mutex-make-p.scm"
%use (dynamic-thread-mutex-make#p-default) "./dynamic-thread-mutex-make-p-default.scm"

(define (dynamic-thread-mutex-make)
  ((or (dynamic-thread-mutex-make#p)
       dynamic-thread-mutex-make#p-default)))
