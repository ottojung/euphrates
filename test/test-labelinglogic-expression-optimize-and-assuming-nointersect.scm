
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

;; Optimizing non-intersecting negated ground terms
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 1)) (= 1))))

;; Optimizing non-intersecting r7rs terms
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (r7rs odd?))))

;; Negated and non-negated expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 1) (not (= 1)))))

;; Different non-intersecting tuples
(assert=
 '(and (tuple 1 2) (tuple 3 4))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple 1 2) (tuple 3 4))))

;; The same tuples
(assert=
 '(and (tuple 1 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple 1 2) (tuple 1 2))))

;; Tuples with top expressions
(assert=
 '(and (tuple 1 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple 1 2) (tuple 1 2) (and))))

;; Tuples with bottom expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple 1 2) (tuple 1 2) (or))))
