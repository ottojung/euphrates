
%run guile

;; Disables killing during the execution of critical zone.
;; The argument must be 0-arity procedure that does not evaluate non-local jumps,
;; i.e. does not throw exceptions and does not call continuations (beware that yield may call continuations).
%var dynamic-thread-critical-make

%use (dynamic-thread-critical-make#p) "./dynamic-thread-critical-make-p.scm"
%use (dynamic-thread-critical-make#p-default) "./dynamic-thread-critical-make-p-default.scm"

(define (dynamic-thread-critical-make)
  ((or (dynamic-thread-critical-make#p)
       dynamic-thread-critical-make#p-default)))
