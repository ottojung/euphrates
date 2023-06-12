



(define-syntax syntax-append/buf
  (syntax-rules ()
    ((_ cont buf () ()) (syntax-reverse cont buf))
    ((_ cont buf (a . as) bs)
     (syntax-append/buf cont (a . buf) as bs))
    ((_ cont buf as (b . bs))
     (syntax-append/buf cont (b . buf) as bs))))

(define-syntax syntax-append/cont
  (syntax-rules ()
    ((_ (cont a) b)
     (syntax-append cont a b))))

(define-syntax syntax-append
  (syntax-rules ()
    ((_ cont a b) (syntax-append/buf cont () a b))
    ((_ cont a b . bs)
     (syntax-append (syntax-append/cont (cont a)) b . bs))))
