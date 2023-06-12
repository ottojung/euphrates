
(define-syntax partial-apply-helper
  (syntax-rules ()
    ((_ f buf () last) (apply f (reversed-args-f cons* last . buf)))
    ((_ f buf (a . args) last)
     (partial-apply-helper f (a . buf) args last))))

(define-syntax partial-apply
  (syntax-rules ()
    ((_ f . args)
     (lambda xs
       (partial-apply-helper f () args xs)))))
