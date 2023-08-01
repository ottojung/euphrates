
(define (list-split-on predicate lst)
  (let loop ((lst lst)
             (buf '())
             (ret '())
             (last-split? #f))
    (cond
     ((null? lst)
      (if (or last-split? (not (null? buf)))
          (reverse (cons (reverse buf) ret))
          (reverse ret)))
     ((predicate (car lst))
      (loop (cdr lst) '()
            (cons (reverse buf) ret)
            #t))
     (else
      (loop (cdr lst) (cons (car lst) buf) ret #f)))))
