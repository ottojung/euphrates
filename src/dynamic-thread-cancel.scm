
%run guile

;; Kills the current thread when it calls yield,
;; so does not kill threads right away.
%var dynamic-thread-cancel

%use (dynamic-thread-cancel#p) "./dynamic-thread-cancel-p.scm"
%use (dynamic-thread-cancel#p-default) "./dynamic-thread-cancel-p-default.scm"

(define (dynamic-thread-cancel)
  ((or (dynamic-thread-cancel#p)
       dynamic-thread-cancel#p-default)))
