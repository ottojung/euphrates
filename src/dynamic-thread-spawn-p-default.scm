
%run guile

%use (np-thread-global-spawn) "./np-thread.scm"

%var dynamic-thread-spawn#p-default

(define dynamic-thread-spawn#p-default
  np-thread-global-spawn)
