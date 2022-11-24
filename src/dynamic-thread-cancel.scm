
%run guile

;; Kills the current thread when it calls yield,
;; so does not kill threads right away.
%var dynamic-thread-cancel

%use (dynamic-thread-cancel#p) "./dynamic-thread-cancel-p.scm"
%use (raisu) "./raisu.scm"

(define (dynamic-thread-cancel th)
  ((or (dynamic-thread-cancel#p)
       (raisu 'threading-system-is-not-parameterized)) th))
