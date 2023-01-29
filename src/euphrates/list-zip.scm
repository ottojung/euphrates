
%run guile

%var list-zip

(define (list-zip a b)
  (let loop ((a a) (b b) (buf '()))
    (if (null? a) (reverse buf)
        (if (null? b) (reverse buf)
            (loop (cdr a) (cdr b) (cons (cons (car a) (car b)) buf))))))
