


(define-syntax define-pair
  (syntax-rules ()
    ((_ (a b) value)
     (define-values (a b)
       (let ((v value))
         (values (car v) (cdr v)))))))
