
%run guile

%var fn

%use (syntax-map) "./syntax-map.scm"

(define-syntax identity-continuation
  (syntax-rules ()
    ((_ x) x)))

(define-syntax fn%-replace1
  (syntax-rules (%)
    ((_ arg-name (x . xs)) (syntax-map identity-continuation fn%-replace1 arg-name (x . xs)))
    ((_ arg-name %) arg-name)
    ((_ arg-name expr) expr)))

;; Makes 1-argument lambda with a hole marked by "%".
;; Works even if "%" is deeply nested.
(define-syntax fn
  (syntax-rules ()
    ((_ . args)
     (lambda (arg-name)
       (fn%-replace1 arg-name args)))))
