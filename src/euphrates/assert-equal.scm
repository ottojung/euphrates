
(define-syntax assert=
  (syntax-rules ()
    ((_ a b . printf-args)
     (assert (equal? a b) . printf-args))))
