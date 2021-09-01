
%run guile

%use (sys-thread-sleep) "./sys-thread.scm"

%var dynamic-thread-sleep#p-default

(define dynamic-thread-sleep#p-default
  sys-thread-sleep)

