
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






;; A complex case combining '=' and 'r7rs [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (= 3))))

;; A complex case combining '=' and 'r7rs [2]
(assert=
 '(and (r7rs even?) (= 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (= 2))))

;; A complex case combining '=' and 'r7rs [3]
(assert=
 '(and (= 2) (r7rs even?))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (r7rs even?))))

;; A complex case combining '=' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (r7rs even?) (= 3))))

;; Checking negation of 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs odd?) (not (r7rs odd?)))))

;; Optimizing tuples with different expressions
(assert=
 '(and (tuple (= 1)) (tuple (r7rs odd?)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1)) (tuple (r7rs odd?)))))

;; Optimizing tuples with the same expressions
(assert=
 '(and (tuple (= 1)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1)) (tuple (= 1)))))

;; Mixing 'tuple and 'not in a single expression
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1)) (not (tuple (= 1))))))

;; Combining '= and 'r7rs with opposite values
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 1) (r7rs even?))))

;; More complex case with '= and 'r7rs
(assert=
 '(and (= 2) (r7rs even?))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (= 2) (= 2) (r7rs even?))))

;; Complex case with 'tuple and 'not
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (r7rs odd?)) (not (tuple (= 1) (r7rs odd?))))))

;; Case with 'tuple and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1)) (r7rs even?))))

;; Case with 'tuple and 'not with multiple types
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (r7rs odd?)) (not (= 1)) (not (r7rs odd?)))))
