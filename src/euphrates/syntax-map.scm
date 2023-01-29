
(cond-expand
 (guile
  (define-module (euphrates syntax-map)
    :export (syntax-map)
    :use-module ((euphrates syntax-reverse) :select (syntax-reverse)))))



(define-syntax syntax-map/buf/cont
  (syntax-rules ()
    ((_ (cont buf fun xs) funx)
     (syntax-map/buf cont (funx . buf) fun . xs))))

(define-syntax syntax-map/buf
  (syntax-rules ()
    ((_ cont buf fun) (syntax-reverse cont buf))
    ((_ cont buf (fun ctxarg) x . xs)
     (fun (syntax-map/buf/cont (cont buf (fun ctxarg) xs))
          ctxarg
          x))
    ((_ cont buf fun x . xs)
     (fun (syntax-map/buf/cont (cont buf fun xs))
          x))))

(define-syntax syntax-map
  (syntax-rules ()
    ((_ cont fun args-to-map)
     (syntax-map/buf cont () fun . args-to-map))))
