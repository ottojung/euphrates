


(define (list-length=<? target-length lst)
  (let loop ((target-length target-length) (lst lst))
    (if (<= target-length 0) #t
        (if (null? lst) #f
            (loop (- target-length 1) (cdr lst))))))
