
%run guile

%use (sys-thread-spawn) "./sys-thread.scm"

%var dynamic-thread-spawn#p-default

(define dynamic-thread-spawn#p-default
  sys-thread-spawn)
