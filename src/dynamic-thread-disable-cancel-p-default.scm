
%run guile

%var dynamic-thread-disable-cancel#p-default

%use (np-thread-global-disable-cancel) "./np-thread.scm"

(define dynamic-thread-disable-cancel#p-default
  (lambda _ 0))
