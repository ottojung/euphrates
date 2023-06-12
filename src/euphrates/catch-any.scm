


(cond-expand
 (guile

  (define [catch-any body handler]
    (catch #t body
       (lambda err (handler err))))

  ))
