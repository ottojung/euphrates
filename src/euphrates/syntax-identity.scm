
(cond-expand
 (guile
  (define-module (euphrates syntax-identity)
    :export (syntax-identity))))


(define-syntax syntax-identity
  (syntax-rules ()
    ((_ x) x)))
