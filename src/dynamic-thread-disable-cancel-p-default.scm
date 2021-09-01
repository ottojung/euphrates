
%run guile

%var dynamic-thread-disable-cancel#p-default

%use (sys-thread-disable-cancel) "./sys-thread.scm"

(define dynamic-thread-disable-cancel#p-default
  sys-thread-disable-cancel)
