
(cond-expand
 (guile
  (define-module (euphrates conss)
    :export (conss))))

(cond-expand
 (guile
  (define conss cons*))
 (racket
  (define conss list*)))
