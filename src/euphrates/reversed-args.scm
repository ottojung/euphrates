
(define-syntax reversed-args-buf
  (syntax-rules ()
    ((_ (x . xs) buf)
     (reversed-args-buf xs (x . buf)))
    ((_ () buf)
     buf)))

(define-syntax reversed-args
  (syntax-rules ()
    ((_ . args)
     (reversed-args-buf args ()))))
