
(cond-expand
 (guile
  (define (catch-any body handler)
    (catch #t body
           (lambda err (handler err)))))
 (else
  (define (catch-any body handler)
    (with-exception-handler
     (lambda (x) (handler x))
     body))))
