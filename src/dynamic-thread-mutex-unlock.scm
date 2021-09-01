
%run guile

%var dynamic-thread-mutex-unlock!

%use (dynamic-thread-mutex-unlock!#p) "./dynamic-thread-mutex-unlock-p.scm"
%use (dynamic-thread-mutex-unlock!#p-default) "./dynamic-thread-mutex-unlock-p-default.scm"

(define (dynamic-thread-mutex-unlock!)
  ((or (dynamic-thread-mutex-unlock!#p)
       dynamic-thread-mutex-unlock!#p-default)))
