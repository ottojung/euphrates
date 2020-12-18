
%run guile

%use (dynamic-thread-spawn#p-default) "./dynamic-thread-spawn-p-default.scm"

%var dynamic-thread-spawn#p
%var dynamic-thread-spawn

(define dynamic-thread-spawn#p
  (make-parameter dynamic-thread-spawn#p-default))
(define (dynamic-thread-spawn thunk)
  ((dynamic-thread-spawn#p) thunk))
