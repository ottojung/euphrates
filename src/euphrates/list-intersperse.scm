



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

