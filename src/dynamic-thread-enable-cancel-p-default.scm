
%run guile

%var dynamic-thread-enable-cancel#p-default

%use (sys-thread-enable-cancel) "./sys-thread.scm"

(define dynamic-thread-enable-cancel#p-default
  sys-thread-enable-cancel)
