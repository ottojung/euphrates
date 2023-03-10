
(cond-expand
 (guile
  (define-module (euphrates list-drop-n)
    :export (list-drop-n))))


(define (list-drop-n n lst)
  (let loop ((n n) (lst lst))
    (if (or (>= 0 n) (null? lst))
        lst
        (loop (- n 1) (cdr lst)))))
