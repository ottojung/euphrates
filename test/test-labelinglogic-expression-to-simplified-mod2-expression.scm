
(define (test-eq output input)
  (assert= output (labelinglogic:expression->simplified-mod2-expression input)))

;; Test an AND expression conversion.
(test-eq '(* x y) '(and x y))

;; Test an OR expression conversion with 2 arguments.
(test-eq '(+ A B (* A B)) '(or A B))

;; ;; Test an OR expression conversion with no arguments (should be 0).
;; (test-eq '(+) '(or))

;; ;; Test an OR expression with one argument (should return same expression).
;; (test-eq 'A '(or A))

;; ;; Test a NOT expression conversion.
;; (test-eq '(+ 1 x) '(not x))

;; ;; Test a known type that is not modified (assuming '= is a direct mapping).
;; (test-eq '(= A B) '(= A B))
;; (test-eq '(* (+ 1 x) (* y z)) '(and (not x) (and y z)))

;; ;; Test an OR expression with an AND expression nested inside.
;; (test-eq '(+ A (* B C) (* A (* B C))) '(or A (and B C)))

;; ;; Test multi-ary OR expression (more than two arguments).
;; (test-eq '(+ A B (* A B) C (* (+ A B (* A B)) C))
;;          '(or A B C))

;; ;; Test nested NOT expressions.
;; (test-eq '(+ 1 (+ 1 x)) '(not (not x)))

;; ;; Test deeply nested expressions (AND within OR within AND).
;; (test-eq '(* (+ A (* B C) (* A (* B C))) (+ 1 D))
;;          '(and (or A (and B C)) (not D)))

;; ;; Test multi-ary AND expressions (more than two arguments, in this case, four arguments).
;; (test-eq '(* A B C D) '(and A B C D))

;; ;; Edge case: AND expr with one argument (should behave like a loop with one item).
;; (test-eq '(* A) '(and A))

;; ;; Edge case: AND with 0 arguments, which might be an empty conjunction.
;; ;; Assuming the behavior should return 1 for the neutral element of multiplication.
;; (test-eq '(*) '(and))

;; ;; Test a sequence of nested ORs with varying number of arguments.
;; (test-eq '(+ A
;;              (+ B C (* B C))
;;              (* A (+ B C (* B C)))
;;              D
;;              (* (+ A (+ B C (* B C)) (* A (+ B C (* B C)))) D))
;;          '(or A (or B C) D))

;; ;; Test that unknown expression types raise a specific error.
;; (assert-throw 'unknown-expr-type
;;               (labelinglogic:expression->mod2-expression '(unknown-type A B)))
