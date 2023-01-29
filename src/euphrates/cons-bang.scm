
(cond-expand
 (guile
  (define-module (euphrates cons-bang)
    :export (cons!))))


(define-syntax cons!
  (syntax-rules ()
    ((_ head tail)
     (set! tail (cons head tail)))))
