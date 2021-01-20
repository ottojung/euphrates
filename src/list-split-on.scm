
%run guile

%var list-split-on

(define (list-split-on predicate lst)
  (let loop ((lst lst) (buf (list)) (ret (list)))
    (cond
     ((null? lst)
      (if (null? buf)
          (reverse ret)
          (reverse (cons (reverse buf) ret))))
     ((predicate (car lst))
      (loop (cdr lst) (list)
            (if (null? buf) ret
                (cons (reverse buf) ret))))
     (else
      (loop (cdr lst) (cons (car lst) buf) ret)))))
