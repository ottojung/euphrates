
%run guile

%var list-take-n

(define (list-take-n n lst)
  (let loop ((n n) (lst lst))
    (if (or (>= 0 n) (null? lst)) '()
        (cons (car lst) (loop (- n 1) (cdr lst))))))
