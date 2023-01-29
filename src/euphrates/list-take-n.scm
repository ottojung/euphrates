
(cond-expand
 (guile
  (define-module (euphrates list-take-n)
    :export (list-take-n))))


(define (list-take-n n lst)
  (let loop ((n n) (lst lst))
    (if (or (>= 0 n) (null? lst)) '()
        (cons (car lst) (loop (- n 1) (cdr lst))))))
