
%run guile

%var list-init

(define (list-init lst)
  (if (null? lst) lst
      (let loop ((lst lst))
        (if (null? (cdr lst)) '()
            (cons (car lst) (loop (cdr lst)))))))
