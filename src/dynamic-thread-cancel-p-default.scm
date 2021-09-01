
%run guile

%var dynamic-thread-cancel#p-default

%use (np-thread-global-cancel) "./np-thread.scm"

(define dynamic-thread-cancel#p-default
  np-thread-global-cancel)
