



(define-syntax compose-under-par-cont
  (syntax-rules ()
    ((_ op buf) (op . buf))))

(define-syntax compose-under-par-helper
  (syntax-rules ()
    [(_ args op buf ())
     (lambda args
       (syntax-reverse (compose-under-par-cont op) buf))]
    [(_ args op buf (f . fs))
     (compose-under-par-helper
      (x . args) op
      ((f x) . buf)
      fs)]))

(define-syntax compose-under-par
  (syntax-rules ()
    ((_ operation . composites)
     (compose-under-par-helper () operation () composites))))
