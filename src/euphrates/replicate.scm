
(cond-expand
 (guile
  (define-module (euphrates replicate)
    :export (replicate))))


(define (replicate n x)
  (if (>= 0 n)
      '()
      (cons x (replicate (- n 1) x))))
