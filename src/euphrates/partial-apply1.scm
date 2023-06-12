
(define-syntax partial-apply1-helper
  (syntax-rules ()
    ((_ f buf () last) (reversed-args-f f last . buf))
    ((_ f buf (a . args) last)
     (partial-apply1-helper f (a . buf) args last))))

(define-syntax partial-apply1
  (syntax-rules ()
    ((_ f . args)
     (lambda (x)
       (partial-apply1-helper f () args x)))))
