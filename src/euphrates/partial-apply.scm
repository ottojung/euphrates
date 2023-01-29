
(cond-expand
 (guile
  (define-module (euphrates partial-apply)
    :export (partial-apply)
    :use-module ((euphrates reversed-args-f) :select (reversed-args-f)))))



(define-syntax partial-apply-helper
  (syntax-rules ()
    ((_ f buf () last) (apply f (reversed-args-f cons* last . buf)))
    ((_ f buf (a . args) last)
     (partial-apply-helper f (a . buf) args last))))
(define-syntax-rule (partial-apply f . args)
  (lambda xs
    (partial-apply-helper f () args xs)))
