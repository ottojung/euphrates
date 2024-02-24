
(assert=
 '(and)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and)))

(assert-throw
 'bad-expr-type
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(or)))

(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and a b)))

(assert-throw
 '(and (= 0))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 0) (= 0))))
