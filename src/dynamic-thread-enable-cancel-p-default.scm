
%run guile

%var dynamic-thread-enable-cancel#p-default

%use (np-thread-global-enable-cancel) "./np-thread.scm"

(define dynamic-thread-enable-cancel#p-default
  np-thread-global-enable-cancel)
