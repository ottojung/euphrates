

(cond-expand
 (guile
  (define conss cons*))
 (racket
  (define conss list*)))
