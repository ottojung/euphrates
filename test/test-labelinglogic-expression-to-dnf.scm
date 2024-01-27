
(assert=
 '(or (and x (not y) x) (and x (not y) y))
 (labelinglogic:expression:sugarify
  (labelinglogic:expression:to-dnf
   '(and x (not y) (or x y)))))

(assert=
 '(or (and x (not y) x) (and x (not y) y))
 (labelinglogic:expression:sugarify
  (labelinglogic:expression:to-dnf
   '(and x (not y) (or x y)))))
