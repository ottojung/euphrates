
%run guile

%use (sys-usleep) "./sys-usleep.scm"

%var dynamic-thread-sleep#p-default

(define dynamic-thread-sleep#p-default
  sys-usleep)

