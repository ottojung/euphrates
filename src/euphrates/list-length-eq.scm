
(cond-expand
 (guile
  (define-module (euphrates list-length-eq)
    :export (list-length=))))


(define (list-length= target-length lst)
  (and (<= 0 target-length)
       (let loop ((target-length target-length) (lst lst))
         (if (= target-length 0)
             (null? lst)
             (if (null? lst) #f
                 (loop (- target-length 1) (cdr lst)))))))
