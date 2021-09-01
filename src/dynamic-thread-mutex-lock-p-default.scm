
%run guile

%var dynamic-thread-mutex-lock!#p-default

%use (np-thread-global-mutex-lock!) "./np-thread.scm"

(define dynamic-thread-mutex-lock!#p-default
  np-thread-global-mutex-lock!)
