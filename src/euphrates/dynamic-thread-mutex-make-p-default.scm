
%run guile

%var dynamic-thread-mutex-make#p-default

%use (np-thread-global-mutex-make) "./np-thread.scm"

(define dynamic-thread-mutex-make#p-default
  (lambda _ 0))
