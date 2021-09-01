
%run guile

%var dynamic-thread-mutex-lock!#p-default

%use (sys-mutex-lock!) "./sys-mutex-lock.scm"

(define dynamic-thread-mutex-lock!#p-default
  sys-mutex-lock!)
