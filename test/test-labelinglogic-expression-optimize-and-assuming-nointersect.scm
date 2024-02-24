
(assert=
 '(and)
 (labelinglogic:expression:optimize/and-assuming-nointersect '(and)))

(assert-throw
 'bad-expr-type
 (labelinglogic:expression:optimize/and-assuming-nointersect '(or)))

(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/and-assuming-nointersect '(and (or))))
