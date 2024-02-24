
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

(assert=
 '(and (= 0))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 0) (= 0))))

(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 0) (= 1))))
