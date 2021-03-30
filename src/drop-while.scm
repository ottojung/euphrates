
%run guile

%var drop-while

(define (drop-while pred lst)
  (let loop ((lst lst))
    (if (null? lst) '()
        (if (pred (car lst))
            (loop (cdr lst))
            lst))))


