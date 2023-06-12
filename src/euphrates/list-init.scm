


(define (list-init lst)
  (let loop ((lst lst))
    (if (null? (cdr lst)) '()
        (cons (car lst) (loop (cdr lst))))))
