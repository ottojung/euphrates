
%run guile

%var dynamic-thread-mutex-unlock!#p-default

%use (sys-thread-mutex-unlock!) "./sys-thread.scm"

(define dynamic-thread-mutex-unlock!#p-default
  sys-thread-mutex-unlock!)
