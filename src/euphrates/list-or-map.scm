


(define (list-or-map f lst)
  (let loop ((buf lst))
    (if (null? buf) #f
        (if (f (car buf))
            #t
            (loop (cdr buf))))))
