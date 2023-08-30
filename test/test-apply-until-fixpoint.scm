
(assert=
 0

 (apply-until-fixpoint
  (lambda (x) (floor (/ x 2)))
  999))

