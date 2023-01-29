
(cond-expand
 (guile
  (define-module (euphrates define-pair)
    :export (define-pair))))


(define-syntax define-pair
  (syntax-rules ()
    ((_ (a b) value)
     (define-values (a b)
       (let ((v value))
         (values (car v) (cdr v)))))))
