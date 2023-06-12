

(cond-expand
 (guile
  (define (eval-in-current-namespace body)
    (eval body (interaction-environment))))
 (racket
  (define (eval-in-current-namespace body)
    (eval body))))
