
(cond-expand
 (guile
  (define-module (euphrates list-intersperse)
    :export (list-intersperse)
    :use-module ((euphrates conss) :select (conss)))))



(define (list-intersperse element lst)
  (let lp ((buf lst))
    (if (pair? buf)
        (let ((rest (cdr buf)))
          (if (null? rest)
              buf
              (conss (car buf)
                     element
                     (lp rest))))
        '())))

