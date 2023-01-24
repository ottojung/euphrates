
%run guile

%var fn

%use (syntax-map) "./syntax-map.scm"
%use (syntax-identity) "./syntax-identity.scm"

(define-syntax fn%-replace1
  (syntax-rules (%)
    ((_ cont arg-name (x . xs)) (syntax-map cont (fn%-replace1 arg-name) (x . xs)))
    ((_ (cont ctxarg) arg-name %) (cont ctxarg arg-name))
    ((_ cont arg-name %) (cont arg-name))
    ((_ (cont ctxarg) arg-name expr) (cont ctxarg expr))
    ((_ cont arg-name expr) (cont expr))))

;; Makes 1-argument lambda with a hole marked by "%".
;; Works even if "%" is deeply nested.
(define-syntax fn
  (syntax-rules ()
    ((_ . args)
     (lambda (arg-name)
       (fn%-replace1 syntax-identity arg-name args)))))
