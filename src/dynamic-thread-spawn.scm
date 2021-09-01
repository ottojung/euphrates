
%run guile

%use (dynamic-thread-spawn#p) "./dynamic-thread-spawn-p.scm"
%use (dynamic-thread-spawn#p-default) "./dynamic-thread-spawn-p-default.scm"

%var dynamic-thread-spawn

(define (dynamic-thread-spawn thunk)
  ((or (dynamic-thread-spawn#p)
       dynamic-thread-spawn#p-default) thunk))
