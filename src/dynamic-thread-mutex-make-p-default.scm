
%run guile

%var dynamic-thread-mutex-make#p-default

%use (sys-thread-mutex-make) "./sys-thread.scm"

(define dynamic-thread-mutex-make#p-default
  sys-thread-mutex-make)
