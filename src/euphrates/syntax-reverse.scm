
(cond-expand
 (guile
  (define-module (euphrates syntax-reverse)
    :export (syntax-reverse))))


(define-syntax syntax-reverse-buf
  (syntax-rules ()
    ((_ cont (x . xs) buf)
     (syntax-reverse-buf cont xs (x . buf)))
    ((_ (cont cont-arg) () buf)
     (cont cont-arg buf))
    ((_ cont () buf)
     (cont buf))))

(define-syntax syntax-reverse
  (syntax-rules ()
    ((_ cont lst)
     (syntax-reverse-buf cont lst ()))))
