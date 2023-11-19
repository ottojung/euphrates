
(define (test-eq output input)
  (assert= output (labelinglogic:expression->mod2-expression input)))

;; Test an AND expression conversion.
(test-eq '(and x y) '(and x y))

;; Test an OR expression conversion with 2 arguments.
(test-eq '(xor A B (and A B)) '(or A B))

;; Test an OR expression conversion with no arguments (should be 0).
(test-eq '(xor) '(or))

;; Test an OR expression with one argument (should return same expression).
(test-eq 'A '(or A))

;; Test a NOT expression conversion.
(test-eq '(xor (and) x) '(not x))

;; Test a known type that is not modified (assuming '= is a direct mapping).
(test-eq '(= A B) '(= A B))
(test-eq '(and (xor (and) x) (and y z)) '(and (not x) (and y z)))

;; Test an OR expression with an AND expression nested inside.
(test-eq '(xor A (and B C) (and A (and B C))) '(or A (and B C)))

;; Test multi-ary OR expression (more than two arguments).
(test-eq '(xor A B (and A B) C (and (xor A B (and A B)) C))
         '(or A B C))

;; Test nested NOT expressions.
(test-eq '(xor (and) (xor (and) x)) '(not (not x)))

;; Test deeply nested expressions (AND within OR within AND).
(test-eq '(and (xor A (and B C) (and A (and B C))) (xor (and) D))
         '(and (or A (and B C)) (not D)))

;; Test multi-ary AND expressions (more than two arguments, in this case, four arguments).
(test-eq '(and A B C D) '(and A B C D))

;; Edge case: AND expr with one argument (should behave like a loop with one item).
(test-eq '(and A) '(and A))

;; Edge case: AND with 0 arguments, which might be an empty conjunction.
;; Assuming the behavior should return (and) for the neutral element of multiplication.
(test-eq '(and) '(and))

;; Test a sequence of nested ORs with varying number of arguments.
(test-eq '(xor A
             (xor B C (and B C))
             (and A (xor B C (and B C)))
             D
             (and (xor A (xor B C (and B C)) (and A (xor B C (and B C)))) D))
         '(or A (or B C) D))

;; Test that unknown expression types raise a specific error.
(assert-throw 'unknown-expr-type
              (labelinglogic:expression->mod2-expression '(unknown-type A B)))
