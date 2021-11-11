
%run guile

%var list-blocks

%use (raisu) "./raisu.scm"
%use (list-span) "./list-span.scm"

;; `(length lst)` must be divisible by `block-size`!
(define (list-blocks block-size lst)
  (let loop ((lst lst) (ret '()))
    (if (null? lst) (reverse ret)
        (call-with-values
            (lambda _ (list-span block-size lst))
          (lambda (left right)
            (loop right (cons left ret)))))))
