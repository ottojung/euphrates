
(cond-expand
 (guile
  (define-module (euphrates system-star-exit-code)
    :export (system*/exit-code))))


(cond-expand
 (guile

  (define system*/exit-code system*)

  ))
(cond-expand
 (racket

  (define system*/exit-code system*/exit-code)

  ))
