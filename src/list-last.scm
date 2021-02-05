
%run guile

%var list-last

(define (list-last L)
  (let loop ((L L))
    (if (null? (cdr L))
        (car L)
        (loop (cdr L)))))
