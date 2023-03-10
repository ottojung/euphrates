
(cond-expand
 (guile
  (define-module (euphrates list-replace-last)
    :export (list-replace-last-element))))


(define (list-replace-last-element new-element lst)
  (let loop ((lst lst) (ret '()))
    (if (null? (cdr lst)) (reverse (cons new-element ret))
        (loop (cdr lst) (cons (car lst) ret)))))
