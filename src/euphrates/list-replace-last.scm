


(define (list-replace-last new-element lst)
  (let loop ((lst lst) (ret '()))
    (if (null? (cdr lst)) (reverse (cons new-element ret))
        (loop (cdr lst) (cons (car lst) ret)))))
