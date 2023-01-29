
(cond-expand
 (guile
  (define-module (euphrates reversed-args-f)
    :export (reversed-args-f))))


(define-syntax reversed-args-f-buf
  (syntax-rules ()
    ((_ f (x . xs) buf)
     (reversed-args-f-buf f xs (x . buf)))
    ((_ f () buf)
     (f . buf))))
(define-syntax-rule (reversed-args-f f . args)
  (reversed-args-f-buf f args ()))
