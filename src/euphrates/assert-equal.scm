
(cond-expand
 (guile
  (define-module (euphrates assert-equal)
    :export (assert=)
    :use-module ((euphrates assert) :select (assert)))))



(define-syntax-rule (assert= a b . printf-args)
  (assert (equal? a b) . printf-args))
