
%run guile

%var dynamic-thread-mutex-lock!#p-default

%use (sys-thread-mutex-lock!) "./sys-thread.scm"

(define dynamic-thread-mutex-lock!#p-default
  sys-thread-mutex-lock!)
