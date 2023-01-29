
(cond-expand
 (guile
  (define-module (euphrates catch-any)
    :export (catch-any))))


(cond-expand
 (guile

  (define [catch-any body handler]
    (catch #t body
       (lambda err (handler err))))

  ))
(cond-expand
 (racket
  ;; TODO
  ))
