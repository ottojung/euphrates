
(define (positive? x)
  (> x 0))

(define (negative? x)
  (< x 0))

; Test with even numbers
(assert=
 0
 (list-count even? (list 1 3 5 7 9)))

; Test with odd numbers
(assert=
 0
 (list-count odd? (list 2 4 6 8 10)))

; Test with positive numbers
(assert=
 5
 (list-count positive? (list 1 2 3 4 5)))

; Test with negative numbers
(assert=
 5
 (list-count negative? (list -1 -2 -3 -4 -5)))

; Test with zeros
(assert=
 5
 (list-count zero? (list 0 0 0 0 0)))

; Test with empty list
(assert=
 0
 (list-count positive? '()))

; Test with single-element list
(assert=
 1
 (list-count even? (list 2)))

; Test with all elements satisfying the predicate
(assert=
 5
 (list-count positive? (list 1 2 3 4 5)))

; Test with no elements satisfying the predicate
(assert=
 0
 (list-count negative? (list 1 2 3 4 5)))

; Test with some elements satisfying the predicate
(assert=
 2
 (list-count even? (list 1 2 3 4 5)))

; Test with list of zeros
(assert=
 5
 (list-count zero? (list 0 0 0 0 0)))

; Test with list of positive and negative numbers
(assert=
 3
 (list-count positive? (list -1 -2 1 2 3)))

; Test with list of positive and zero numbers
(assert=
 3
 (list-count positive? (list 0 0 1 2 3)))

; Test with list of negative and zero numbers
(assert=
 3
 (list-count negative? (list 0 0 -1 -2 -3)))

; Test with list of all the same number
(assert=
 5
 (list-count (lambda (x) (= x 1)) (list 1 1 1 1 1)))

; Test with list of all different numbers
(assert=
 1
 (list-count (lambda (x) (= x 1)) (list 1 2 3 4 5)))
