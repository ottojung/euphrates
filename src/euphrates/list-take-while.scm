


(define (list-take-while pred lst)
  (let loop ((lst lst))
    (if (null? lst) '()
        (if (pred (car lst))
            (cons (car lst) (loop (cdr lst)))
            '()))))


