
(cond-expand
 (guile
  (define-module (euphrates conss)
    :export (conss))))


(cond-expand
 (guile

  (define conss cons*)

  ))

(cond-expand
 (racket

  (define conss list*)

  ))
