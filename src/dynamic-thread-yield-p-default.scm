
%run guile

%var dynamic-thread-yield#p-default

%use (np-thread-global-yield) "./np-thread.scm"

(define dynamic-thread-yield#p-default
  np-thread-global-yield)
