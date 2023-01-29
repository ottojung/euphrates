
(cond-expand
 (guile
  (define-module (euphrates eval-in-current-namespace)
    :export (eval-in-current-namespace))))


(cond-expand
 (guile

  (define (eval-in-current-namespace body)
    (eval body (interaction-environment)))

  ))

(cond-expand
 (racket

  (define (eval-in-current-namespace body)
    (eval body))

  ))
