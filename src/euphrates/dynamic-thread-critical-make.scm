
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-critical-make)
    :export (dynamic-thread-critical-make)
    :use-module ((euphrates dynamic-thread-critical-make-p) :select (dynamic-thread-critical-make#p))
    :use-module ((euphrates dynamic-thread-critical-make-p-default) :select (dynamic-thread-critical-make#p-default)))))

;; Disables killing during the execution of critical zone.
;; The argument must be 0-arity procedure that does not evaluate non-local jumps,
;; i.e. does not throw exceptions and does not call continuations (beware that yield may call continuations).


(define (dynamic-thread-critical-make)
  ((or (dynamic-thread-critical-make#p)
       dynamic-thread-critical-make#p-default)))
