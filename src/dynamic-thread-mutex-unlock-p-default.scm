
%run guile

%var dynamic-thread-mutex-unlock!#p-default

%use (np-thread-global-mutex-unlock!) "./np-thread.scm"

(define dynamic-thread-mutex-unlock!#p-default
  np-thread-global-mutex-unlock!)
