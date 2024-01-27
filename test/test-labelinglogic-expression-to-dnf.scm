
(define (test expected input)
  (assert=
   expected
   (labelinglogic:expression:sugarify
    (labelinglogic:expression:to-dnf
     input))))


(test
 '(or (and x (not y) x) (and x (not y) y))
 '(and x (not y) (or x y)))
