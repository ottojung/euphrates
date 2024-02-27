
(assert=
 '(and)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and)))

(assert=
 '(and (= 0))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 0) (= 0))))

(assert=
 '(and (= 0))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 0) (= 0) (= 0) (= 0) (= 0))))

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
 '(and (tuple (= 1) (= 2)) (tuple (= 3) (= 4)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (= 2)) (tuple (= 3) (= 4)))))

;; The same tuples
(assert=
 '(and (tuple (= 1) (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (= 2)) (tuple (= 1) (= 2)))))

;; Tuples with top expressions
(assert=
 '(and (tuple (= 1) (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (= 2)) (tuple (= 1) (= 2)) (and))))

;; Tuples with bottom expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (= 2)) (tuple (= 1) (= 2)) (or))))

;; Combining '=' and negated '=' [1]
(assert=
 '(and (= 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (not (= 3)))))

;; A complex case combining '=' and 'r7rs [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (= 3))))

;; A complex case combining '=' and 'r7rs [2]
(assert=
 '(and (= 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (= 2))))

;; A complex case combining '=' and 'r7rs [3]
(assert=
 '(and (= 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (r7rs even?))))

;; A complex case combining '=' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (r7rs even?) (= 3))))

;; A complex case combining '=' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 3) (r7rs even?) (= 2))))

;; A complex case combining '=' and 'r7rs [6]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (= 2) (= 4))))

;; A complex case combining '=' and 'r7rs [7]
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 4) (r7rs even?) (= 2))))

;; A complex case combining 'not =' and 'r7rs [1]
(assert=
 '(and (r7rs even?) (not (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (not (= 2)))))

;; A complex case combining 'not =' and 'r7rs [2]
(assert=
 '(and (r7rs even?))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (not (= 3)))))

;; A complex case combining 'not =' and 'r7rs [3]
(assert=
 '(and (r7rs even?))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 3)) (r7rs even?))))

;; A complex case combining 'not =' and 'r7rs [3]
(assert=
 '(and (r7rs even?))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 3)) (r7rs even?) (not (= 3)) (not (= 3)))))

;; A complex case combining 'not =' and 'r7rs [4]
(assert=
 '(and (r7rs even?) (not (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 3)) (r7rs even?) (not (= 2)))))

;; A complex case combining 'not =' and 'r7rs [5]
(assert=
 '(and (r7rs even?) (not (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (not (= 2)) (not (= 3)))))

;; A complex case combining 'not =' and 'r7rs [6]
(assert=
 '(and (not (= 4)) (r7rs even?) (not (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 4)) (r7rs even?) (not (= 2)) (not (= 3)))))

;; A complex case combining 'not =' and 'r7rs [7]
(assert=
 '(and (not (= 4)) (r7rs even?) (not (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 3)) (not (= 4)) (r7rs even?) (not (= 2)))))

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
 '(and (= 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (= 2) (= 2) (r7rs even?))))

;; More complex case with '= and 'r7rs
(assert=
 '(and (= 2))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (= 2) (= 2) (r7rs even?) (= 2) (= 2))))

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

;; Testing with null values
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 0) (not (= 0)))))

;; Testing single tuple optimization
(assert=
 '(and (tuple (= 2)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 2)) (tuple (= 2)))))

;; Testing with multiple 'r7rs expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (r7rs odd?) (r7rs zero?))))

;; Testing with negated and non-negated 'r7rs expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs even?) (not (r7rs even?)))))

;; Testing with opposite 'r7rs expression
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs positive?) (r7rs negative?))))

;; Test nonintersect assumption on r7rs.
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs positive?) (r7rs integer?))))

;; Testing mixture of '= and 'r7rs expression with a common numeric value.
(define (test-1923123 expr)
  (define result
    (labelinglogic:expression:optimize/and-assuming-nointersect
     expr))

  (or (equal? result '(and (= 2)))
      (equal? result '(or))))

(assert (test-1923123 '(and (= 2) (r7rs positive?) (r7rs integer?))))

;; Case with '= and 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (tuple (= 1)))))

;; Case with '= and complex 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (tuple (r7rs even?) (= 3)))))

;; Case with 'not and 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 2)) (tuple (= 2)))))

;; Case with 'not and complex 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (r7rs even?)) (tuple (r7rs even?) (= 3)))))

;; Case with '= and negated 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (not (tuple (= 2))))))

;; Case with 'not and negated 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (= 2)) (not (tuple (= 2))))))

;; Case with negated 'tuple and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (not (tuple (= 1))) (r7rs odd?))))

;; Case with 'tuple, 'not, '= and 'r7rs values
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1)) (not (tuple (= 1))) (r7rs odd?) (= 2))))

;; ;; Case with 'tuple containing other 'tuple
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/and-assuming-nointersect
;;   '(and (tuple (= 1) (tuple (r7rs odd?))) (not (tuple (= 1))))))

;; Case with complex mixture of types
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs odd?) (not (= 1)) (not (r7rs odd?)) (tuple (= 2) (r7rs even?)))))

;; Case with identical 'tuple values
(assert=
 '(and (tuple (= 1) (r7rs odd?)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (r7rs odd?)) (tuple (= 1) (r7rs odd?)))))

;; Case with non-identical 'tuple values
(assert=
 '(and (tuple (= 1) (r7rs odd?)) (tuple (= 2) (r7rs even?)))
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (= 1) (r7rs odd?)) (tuple (= 2) (r7rs even?)))))

;; Case with '=, 'tuple and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (= 2) (r7rs even?) (tuple (= 2) (r7rs even?)))))

;; More complex case
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (r7rs positive?) (not (= 2)) (tuple (= 2) (r7rs odd?)))))

;; Complex case with 'tuple, 'not and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (r7rs even?)) (= 2) (not (r7rs odd?)))))

;; Complex case with complex 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple (r7rs even?) (= 2)) (r7rs positive?))))

(assert-throw
 'bad-expr-type
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(or)))

(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and a b)))

;; Case with '((and))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '((and))))

;; Case with numbers
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and 1 2 3)))

;; Case with top number
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect 812312))

;; Case with '((or))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '((or))))

;; Case with '((tuple))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '((tuple))))

;; Complex case with '((tuple))' and '((or))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '((tuple) (or))))

;; Bad tuples.
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize/and-assuming-nointersect
  '(and (tuple 1 2))))
