
(assert=
 '(and)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and)))

(assert=
 '(constant 0)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 0) (constant 0))))

(assert=
 '(constant 0)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 0) (constant 0) (constant 0) (constant 0) (constant 0))))

(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 0) (constant 1))))

;; Optimizing non-intersecting negated lemma terms
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 1)) (constant 1))))

;; Optimizing non-intersecting r7rs terms
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (r7rs odd?))))

;; Different non-intersecting tuples
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (constant 2)) (tuple (constant 3) (constant 4)))))

;; Different non-intersecting tuples [1]
(assert=
 '(tuple (constant 2)
         (and (r7rs odd?) (not (constant 3))))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 2) (r7rs odd?))
        (tuple (r7rs even?) (not (constant 3))))))

;; Different non-intersecting tuples [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (constant 2)) (tuple (constant 3) (constant 4)))))

;; The same tuples
(assert=
 '(tuple (constant 1) (constant 2))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (constant 2)) (tuple (constant 1) (constant 2)))))

;; Tuples with same expressions
(assert=
 '(tuple (constant 1) (constant 1))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (constant 1)) (tuple (constant 1) (constant 1)))))

;; Tuples with top expressions
(assert=
 '(tuple (constant 1) (constant 2))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (constant 2)) (tuple (constant 1) (constant 2)) (and))))

;; Tuples with bottom expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (constant 2)) (tuple (constant 1) (constant 2)) (or))))

;; Combining 'constant' and 'not =' [1]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (not (constant 3)))))

;; Combining 'constant' and 'not =' [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (not (constant 2)))))

;; Combining 'constant' and 'not =' [3]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (constant 2))))

;; Combining 'constant' and 'not =' [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 2)) (constant 2))))

;; Combining 'constant' and 'not =' [5]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (constant 2) (not (constant 3)) (not (constant 4)))))

;; Combining 'not =' and 'not =' [1]
(assert=
 '(and (not (constant 2)) (not (constant 3)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 2)) (not (constant 3)))))

;; Combining 'not =' and 'not =' [2]
(assert=
 '(not (constant 2))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 2)) (not (constant 2)))))

;; Combining 'r7rs' and 'not r7rs' [1]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (not (r7rs odd?)))))

;; Combining 'r7rs' and 'not r7rs' [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (not (r7rs even?)))))

;; Combining 'r7rs' and 'not r7rs' [3]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs odd?)) (r7rs even?))))

;; Combining 'r7rs' and 'not r7rs' [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs even?)) (r7rs even?))))

;; Combining 'r7rs' and 'not r7rs' [5]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs odd?)) (r7rs even?) (not (r7rs odd?)) (not (r7rs integer?)))))

;; Combining 'not r7rs' and 'not r7rs' [1]
;; NOTE: This does not simplify because detecting it is impossible.
;; NOTE: If we tried adding a "universe" notion, then we would not be able to use `(and)` anywhere,
;; NOTE: because that would make it the universe, and then this would not simplify again.
(assert=
 '(and (not (r7rs even?)) (not (r7rs odd?)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs even?)) (not (r7rs odd?)))))

;; Combining 'constant' and 'r7rs [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (constant 3))))

;; Combining 'constant' and 'r7rs [2]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (constant 2))))

;; Combining 'constant' and 'r7rs [3]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (r7rs even?))))

;; Combining 'constant' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (r7rs even?) (constant 3))))

;; Combining 'constant' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 3) (r7rs even?) (constant 2))))

;; Combining 'constant' and 'r7rs [6]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (constant 2) (constant 4))))

;; Combining 'constant' and 'r7rs [7]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 4) (r7rs even?) (constant 2))))

;; Combining 'not =' and 'r7rs [1]
(assert=
 '(and (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (not (constant 2)))))

;; Combining 'not =' and 'r7rs [2]
(assert=
 '(and (not (constant 2)) (r7rs even?))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 2)) (r7rs even?))))

;; Combining 'not =' and 'r7rs [3]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [4]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (r7rs even?))))

;; Combining 'not =' and 'r7rs [5]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (r7rs even?) (not (constant 3)) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [6]
(assert=
 '(and (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (r7rs even?) (not (constant 2)))))

;; Combining 'not =' and 'r7rs [7]
(assert=
 '(and (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (not (constant 2)) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [8]
(assert=
 '(and (not (constant 4)) (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 4)) (r7rs even?) (not (constant 2)) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [9]
(assert=
 '(and (not (constant 4)) (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (not (constant 4)) (r7rs even?) (not (constant 2)))))

;; Combining 'constant' and '(not r7rs) [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (not (r7rs even?)))))

;; Combining 'constant' and '(not r7rs) [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs even?)) (constant 2))))

;; Combining 'constant' and '(not r7rs) [3]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 3) (not (r7rs even?)))))

;; Combining '(not =) and '(not r7rs) [1]
(assert=
 '(not (r7rs even?))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs even?)) (not (constant 2)))))

;; Combining '(not =) and '(not r7rs) [2]
(assert=
 '(and (not (r7rs even?)) (not (constant 3)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs even?)) (not (constant 3)))))

;; Checking negation of 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs odd?) (not (r7rs odd?)))))

;; Optimizing tuples with different expressions [1]
(assert=
 '(tuple (constant 1))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1)) (tuple (r7rs odd?)))))

;; Optimizing tuples with different expressions [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 2)) (tuple (r7rs odd?)))))

;; Optimizing tuples with the same expressions
(assert=
 '(tuple (constant 1))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1)) (tuple (constant 1)))))

;; Mixing 'tuple and 'not in a single expression
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1)) (tuple (not (constant 1))))))

;; Combining 'constant and 'r7rs with opposite values
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 1) (r7rs even?))))

;; More complex case with 'constant and 'r7rs
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (constant 2) (constant 2) (r7rs even?))))

;; More complex case with 'constant and 'r7rs
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (constant 2) (constant 2) (r7rs even?) (constant 2) (constant 2))))

;; Complex case with 'tuple and 'not
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (r7rs odd?)) (tuple (not (constant 1)) (r7rs odd?)))))

;; Case with 'tuple and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1)) (r7rs even?))))

;; Case with 'tuple and 'not with multiple types
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (r7rs odd?)) (not (constant 1)) (not (r7rs odd?)))))

;; Case with empty 'tuple [1].
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (or)) (tuple (or)))))

;; Case with empty 'tuple [2].
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(tuple (or))))

;; Testing with null values
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 0) (not (constant 0)))))

;; Testing single tuple optimization
(assert=
 '(tuple (constant 2))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 2)) (tuple (constant 2)))))

;; Testing with multiple 'r7rs expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (r7rs odd?) (r7rs zero?))))

;; Testing with negated and non-negated 'r7rs expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs even?) (not (r7rs even?)))))

;; Testing with opposite 'r7rs expression
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs positive?) (r7rs negative?))))

;; Test nointersect assumption on r7rs.
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs positive?) (r7rs integer?))))

;; Testing mixture of 'constant and 'r7rs expression with a common numeric value.
(define (test-1923123 expr)
  (define result
    (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
     expr))

  (or (equal? result '(constant 2))
      (equal? result '(or))))

(assert (test-1923123 '(and (constant 2) (r7rs positive?) (r7rs integer?))))

;; Case with 'constant and 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (tuple (constant 1)))))

;; Case with 'constant and complex 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (tuple (r7rs even?) (constant 3)))))

;; Case with 'not and 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 2)) (tuple (constant 2)))))

;; Case with 'not and complex 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (r7rs even?)) (tuple (r7rs even?) (constant 3)))))

;; Case with 'constant and negated 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (tuple (not (constant 2))))))

;; Case with 'not and negated 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 2)) (tuple (not (constant 2))))))

;; Case with negated 'tuple and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (not (constant 1))) (r7rs odd?))))

;; Case with 'tuple, 'not, 'constant and 'r7rs values
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1)) (tuple (not (constant 1))) (r7rs odd?) (constant 2))))

;; Case with 'tuple containing other 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (tuple (r7rs odd?))) (tuple (not (constant 1))))))

;; Case with complex mixture of types
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs odd?) (not (constant 1)) (not (r7rs odd?)) (tuple (constant 2) (r7rs even?)))))

;; Case with identical 'tuple values
(assert=
 '(tuple (constant 1) (r7rs odd?))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (r7rs odd?)) (tuple (constant 1) (r7rs odd?)))))

;; Case with non-identical 'tuple values
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (constant 1) (r7rs odd?)) (tuple (constant 2) (r7rs even?)))))

;; Case with 'constant, 'tuple and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 2) (r7rs even?) (tuple (constant 2) (r7rs even?)))))

;; More complex case
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (r7rs positive?) (not (constant 2)) (tuple (constant 2) (r7rs odd?)))))

;; Complex case with 'tuple, 'not and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (r7rs even?)) (constant 2) (not (r7rs odd?)))))

;; Complex case with complex 'tuple
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple (r7rs even?) (constant 2)) (r7rs positive?))))

;; Case with top. [1]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (and) (constant 3))))

;; Case with top. [2]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 3) (and))))

;; Case with top. [3]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (constant 3) (and) (constant 3))))

;; Case with top. [4]
(assert=
 '(and (not (constant 3)) (not (constant 5)))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not (constant 3)) (and) (not (constant 5)))))

;; Case with top. [5]
(assert=
 '(and)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (and))))

;; Case with top. [5]
(assert=
 '(and)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (and) (and) (and))))

;; Case with bottom. [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (and) (or) (and) (and))))

;; Case with single lemma term.
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(constant 3)))

;; Case with single tuple term [1].
(assert=
 '(tuple (constant 3) (constant 4))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(tuple (constant 3) (constant 4))))

;; Case with single tuple term [2].
(assert=
 '(tuple (constant 5))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(tuple (constant 5))))

;; Simple case with complex 'tuple
(assert=
 '(tuple (and (r7rs even?) (not (constant 2))))
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(tuple (and (r7rs even?) (not (constant 2))))))

;; Case with single bottom.
(assert=
 '(or)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(or)))

;; Case with single top.
(assert=
 '(and)
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and)))

(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and a b)))

;; Case with '((and))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '((and))))

;; Case with numbers
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and 1 2 3)))

;; Case with top number
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  812312))

;; Case with '((or))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '((or))))

;; Case with '((tuple))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '((tuple))))

;; Complex case with '((tuple))' and '((or))'
(assert-throw
 'expression-type-error
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '((tuple) (or))))

;; Bad tuples.
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (tuple 1 2))))

;; Bad nots.
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
  '(and (not 1))))
