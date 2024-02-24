
(assert= '(and) (labelinglogic:expression:optimize/and-assuming-nointersect '(and)))

(assert-throw ' (labelinglogic:expression:optimize/and-assuming-nointersect '(and)))
