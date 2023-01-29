
(cond-expand
 (guile
  (define-module (euphrates list-windows)
    :export (list-windows)
    :use-module ((euphrates list-span) :select (list-span)))))



;; Returns list of views of a "sliding window"
;; `(length lst)` must be larger than `window-size!`
(define (list-windows window-size lst)
  (define-values (start rest) (list-span window-size lst))
  (let loop ((lst rest) (cur start) (ret (list start)))
    (if (null? lst) (reverse ret)
        (let* ((x (car lst))
               (new-cur (append (cdr cur) (list x))))
          (loop (cdr lst)
                new-cur
                (cons new-cur ret))))))
