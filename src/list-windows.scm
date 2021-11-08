
%run guile

%var list-windows

%use (raisu) "./raisu.scm"
%use (list-span) "./list-span.scm"

;; `(length lst)` must be divisible by `window-size!`
(define (list-windows window-size lst)
  (let loop ((lst lst) (ret '()))
    (if (null? lst) (reverse ret)
        (call-with-values
            (lambda _ (list-span window-size lst))
          (lambda (left right)
            (loop right (cons left ret)))))))
