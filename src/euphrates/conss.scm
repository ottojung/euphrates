
(cond-expand
 (racket
  (define conss list*))
 (else
  (define conss
    (case-lambda
     ((x) x)
     ((x y) (cons x y))
     ((x y . rest)
      (let loop ((x x) (y y) (rest rest))
        (if (null? rest)
            (cons x y)
            (cons x (loop y (car rest) (cdr rest))))))))))
