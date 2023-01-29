
(cond-expand
 (guile
  (define-module (euphrates syntax-map-noeval)
    :export (syntax-map/noeval)
    :use-module ((euphrates syntax-reverse) :select (syntax-reverse)))))



(define-syntax syntax-map/noeval/buf
  (syntax-rules ()
    ((_ cont buf fun) (syntax-reverse cont buf))
    ((_ cont buf (fun ctxarg) x . xs) (syntax-map/noeval/buf cont ((fun ctxarg x) . buf) (fun ctxarg) . xs))
    ((_ cont buf fun x . xs) (syntax-map/noeval/buf cont ((fun x) . buf) fun . xs))))

(define-syntax syntax-map/noeval
  (syntax-rules ()
    ((_ cont fun args-to-map)
     (syntax-map/noeval/buf cont () fun . args-to-map))))
