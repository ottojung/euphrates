
(cond-expand
 (guile
  (define-module (euphrates reversed-args)
    :export (reversed-args))))


(define-syntax reversed-args-buf
  (syntax-rules ()
    ((_ (x . xs) buf)
     (reversed-args-buf xs (x . buf)))
    ((_ () buf)
     buf)))
(define-syntax-rule (reversed-args . args)
  (reversed-args-buf args ()))

