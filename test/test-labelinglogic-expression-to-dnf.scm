
(define (test expected input)
  (assert=
   expected
   (labelinglogic:expression:sugarify
    (labelinglogic:expression:to-dnf
     input))))


(test
 '(or (and x (not y) x) (and x (not y) y))
 '(and x (not y) (or x y)))


;;;;;

; Test for a simple OR expression
(test
 '(or x y)
 '(or x y))

; Test for a simple AND expression
(test
 '(and x y)
 '(and x y))

; Test for De Morgan's laws
(test
 '(or (not x) (not y))
 '(not (and x y)))

; Test for double negation
(test
 'x
 '(not (not x)))

; Test for distributive law conversion to DNF
(test
 '(or a (and b c))
 '(or a (and b c)))

; Test for distributive law with multiple ANDs
(test
 '(or a (and b c) (and d e))
 '(or a (and b c) (and d e)))

; Test for distributive law with nested ORs inside ANDs
(test
 '(and (or a b) (or c d))
 '(or (and c a) (and c b) (and d a) (and d b)))

;; ; Test for distributive law with nested ANDs inside ORs
;; (test
;;  '(or (and a b) (and c d))
;;  '(or (and a b) (and c d)))

;; ; Test with nested NOT expressions
;; (test
;;  '(not (or (not x) y))
;;  '(and x (not y)))

;; ; Test with nested ANDs and ORs
;; (test
;;  '(and (or a (not b)) (or c d))
;;  '(and (or a (not b)) (or c d)))

;; ; Test that ensures idempotence (x OR x = x) and (x AND x = x)
;; (test
;;  '(or x x)
;;  'x)

;; (test
;;  '(and x x)
;;  'x)

;; ; Test that involves all operators in a more complex expression
;; (test
;;  '(or (and (not a) b) (and a (not b)) (and a b))
;;  '(and a (or (not a) b) (or (not b) b)))

