
%run guile

%use (dynamic-thread-sleep#p-default) "./dynamic-thread-sleep-p-default.scm"

%var dynamic-thread-sleep#p
%var dynamic-thread-sleep

(define (dynamic-thread-sleep us)
  ((or (dynamic-thread-sleep#p)
       dynamic-thread-sleep#p-default) us))

