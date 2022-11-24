
%run guile

%use (dynamic-thread-spawn#p) "./dynamic-thread-spawn-p.scm"
%use (raisu) "./raisu.scm"

%var dynamic-thread-spawn

(define (dynamic-thread-spawn thunk)
  ((or (dynamic-thread-spawn#p)
       (raisu 'threading-system-is-not-parameterized)) thunk))
