
%run guile

%use (dynamic-thread-sleep#p-default) "./dynamic-thread-sleep-p-default.scm"

%var dynamic-thread-sleep#p
%var dynamic-thread-sleep

(define dynamic-thread-sleep#p
  (make-parameter dynamic-thread-sleep#p-default))
(define (dynamic-thread-sleep us)
  ((dynamic-thread-sleep#p) us))

