
(define-syntax reversed-args-f-buf
  (syntax-rules ()
    ((_ f (x . xs) buf)
     (reversed-args-f-buf f xs (x . buf)))
    ((_ f () buf)
     (f . buf))))

(define-syntax reversed-args-f
  (syntax-rules ()
    ((_ f . args)
     (reversed-args-f-buf f args ()))))
