
%run guile

%var dynamic-thread-yield#p-default

%use (np-thread-global-yield) "./np-thread.scm"

(define dynamic-thread-yield#p-default
  (lambda _ 0))
