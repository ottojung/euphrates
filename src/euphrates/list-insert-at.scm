
%run guile

%var list-insert-at

(define (list-insert-at L at element)
  (let loop ((L L) (i 0))
    (if (= i at)
        (cons element L)
        (if (null? L) `(,element)
            (cons (car L) (loop (cdr L) (+ 1 i)))))))

