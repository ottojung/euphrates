
%run guile

%var dynamic-thread-mutex-unlock!#p-default

%use (sys-mutex-unlock!) "./sys-mutex-unlock.scm"

(define dynamic-thread-mutex-unlock!#p-default
  sys-mutex-unlock!)
