
(cond-expand
 (guile
  (define-module (euphrates letin)
    :export (letin))))


(cond-expand
 (guile

  (use-modules (srfi srfi-11))

  ))

(define-syntax letin
  (syntax-rules ()
    [(letin ((a . as) b) . ())
     (let-values [[[a . as] b]]
       (values a . as))]
    [(letin ((a . as) b) . bodies)
     (let-values [[[a . as] b]] (letin . bodies))]
    [(letin (a b) . ())
     (let [[a b]] a)]
    [(letin (a b) . bodies)
     (let [[a b]] (letin . bodies))]))


