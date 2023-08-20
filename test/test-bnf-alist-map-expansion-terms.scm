
(define (test1 input-fun input-expr expected-output)
  (assert=
   expected-output
   (bnf-alist:map-expansion-terms input-fun input-expr)))




(test1 identity
       '((prod1 (term1 term2)
                (term3))
         (prod2 (term4 term5)))
       '((prod1 (term1 term2)
                (term3))
         (prod2 (term4 term5))))



(test1 identity
       '((prod1 (term1 term2)
                ())
         (prod2))
       '((prod1 (term1 term2)
                ())
         (prod2)))



(test1 sqrt
       '((prod1 (9 16)
                ())
         (prod2))
       '((prod1 (3 4)
                ())
         (prod2)))
