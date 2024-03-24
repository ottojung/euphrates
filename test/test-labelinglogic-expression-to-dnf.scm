
(define-syntax test
  (syntax-rules ()
    ((_ expected input)
     (assert=
      expected
      (labelinglogic:expression:to-dnf
       input)))))


;; Test for a simple OR expression
(test
 '(or x y)
 '(or x y))

;; Test for a simple AND expression
(test
 '(and x y)
 '(and x y))

;; Simple or + and.
(test
 '(or (and x y) (and x z))
 '(and x (or y z)))

;; Test for De Morgan's laws [1]
(test
 '(or (not x) (not y))
 '(not (and x y)))

;; Test for De Morgan's laws [2]
(test
 '(or (not x) (not y) (not z))
 '(not (and x y z)))

;; Test for double negation
(test
 'x
 '(not (not x)))

;; Test for distributive law conversion to DNF
(test
 '(or a (and b c))
 '(or a (and b c)))

;; Test for distributive law with multiple ANDs
(test
 '(or a (and b c) (and d e))
 '(or a (and b c) (and d e)))

;; Test for distributive law with nested ORs inside ANDs
(test
 '(or (or (and a c) (and b c))
      (or (and a d) (and b d)))
 '(and (or a b) (or c d)))

;; Test for distributive law with nested ANDs inside ORs
(test
 '(or (and a b) (and c d))
 '(or (and a b) (and c d)))

;; Test with nested NOT expressions
(test
 '(and x (not y))
 '(not (or (not x) y)))

;; Test with nested ANDs and ORs
(test
 '(or (or (and a c) (and (not b) c))
      (or (and a d) (and (not b) d)))
 '(and (or a (not b)) (or c d)))

;; Test non-binary
(test
 '(or (and x (and (not y) x))
      (and x (and (not y) y)))
 '(and x (not y) (or x y)))

;; Test that involves all operators in a more complex expression
(test
 '(or (or (and (and a (not a)) (not b))
          (and (and a b) (not b)))
      (or (and (and a (not a)) b)
          (and (and a b) b)))
 '(and a (or (not a) b) (or (not b) b)))

(test
 '(and (= 0) (= 0) (= 0) (= 0) (= 0))
 '(and (= 0) (= 0) (= 0) (= 0) (= 0)))

;; (test
;;  '(and (= 0) (= 0) (= 0) (= 0) (= 0))
;;  '(or (and (= 0) (= 0) (= 0) (= 0) (= 0))))

;; Test constant.
(test 'x 'x)

;; Test negation.
(test '(not x) '(not x))

;; Test negations 1.
(test 'x '(not (not x)))

;; Test negations 2.
(test '(not x) '(not (not (not x))))
