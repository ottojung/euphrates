
(cond-expand
 (guile
  (define-module (euphrates list-zip-with)
    :export (list-zip-with))))


(define (list-zip-with f a b)
  (let loop ((a a) (b b) (buf '()))
    (if (null? a) (reverse buf)
        (if (null? b) (reverse buf)
            (loop (cdr a) (cdr b) (cons (f (car a) (car b)) buf))))))
