
%run guile

%use (sys-thread-yield) "./sys-thread-yield.scm"

%var sys-thread-sleep

(define (sys-thread-sleep us)
  (usleep us)
  (sys-thread-yield))
