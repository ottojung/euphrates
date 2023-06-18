
(cond-expand
 (guile
  (define (catch-specific key body handler)
    (catch key body handler)))
 (else
  (define (catch-specific key body handler)
    (guard
     (err1
      ((and (pair? err1)
            (equal? key (car err1)))
       (apply handler err1)))
     (body)))))
