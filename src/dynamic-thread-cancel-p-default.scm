
%run guile

%var dynamic-thread-cancel#p-default

%use (sys-thread-cancel) "./sys-thread.scm"

(define dynamic-thread-cancel#p-default
  sys-thread-cancel)
