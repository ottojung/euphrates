
%run guile

%use (np-thread-global-sleep) "./np-thread.scm"

%var dynamic-thread-sleep#p-default

(define dynamic-thread-sleep#p-default
  np-thread-global-sleep)

