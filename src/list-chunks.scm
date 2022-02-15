
%run guile

%var list-chunks

%use (raisu) "./raisu.scm"
%use (list-span-n) "./list-span-n.scm"

(define (list-chunks block-size lst)
  (let loop ((lst lst) (ret '()))
    (if (null? lst) (reverse ret)
        (call-with-values
            (lambda _ (list-span-n block-size lst))
          (lambda (left right)
            (loop right (cons left ret)))))))
