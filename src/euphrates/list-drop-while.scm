
(cond-expand
 (guile
  (define-module (euphrates list-drop-while)
    :export (list-drop-while))))


(define (list-drop-while pred lst)
  (let loop ((lst lst))
    (if (null? lst) '()
        (if (pred (car lst))
            (loop (cdr lst))
            lst))))


