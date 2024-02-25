
(define (equalp x y)
  (if (equal? x y) 'left 'skip))

(define (greaterp x y)
  (if (> x y) 'left 'skip))

(define (string-ci=p x y)
  (if (string-ci=? x y) 'left 'skip))

(assert= (list-idempotent equalp (list 1 2 1 4 1))
         (list 1 2 4 1))

(assert= (list-idempotent (lambda (x y)
                            (if (or (= (remainder x y) 0)
                                    (= (remainder y x) 0))
                                'left
                                'skip))
                          (list 2 5 4 3 10 15 7))
         (list 2 5 3 7))

(assert-throw #t (list-idempotent 0 1)) ;; type error

(assert= (list-idempotent
          (lambda (x y)
            (if (< x y) 'left 'right))
          (list 1 2))
         (list 1 2))

;; Test Case 1: Test with empty list
(assert= (list-idempotent equalp '())
         '())

;; Test Case 2: Test with list of identical elements
(assert= (list-idempotent equalp (list 'a 'a 'a 'a 'a))
         (list 'a 'a 'a))

;; Test Case 3: Test with list of distinct elements
(assert= (list-idempotent equalp (list 'x 'y 'z))
         (list 'x 'y 'z))

;; Test Case 4: Test with numbers and greater-than predicate
(assert= (list-idempotent greaterp (list 5 4 3 6 2 7))
         (list 5 3 6 7))

;; Test Case 5: Test with case-insensitive string equality
(assert= (list-idempotent string-ci=p (list "hello" "HELLO" "world" "WORLD" "hello"))
         (list "hello" "world" "hello"))

;; Test Case 6: Test with modulo predicate
(assert= (list-idempotent (lambda (x y)
                            (if (= (modulo x 10) (modulo y 10))
                                'left 'skip))
                          (list 12 22 45 35 88 78))
         (list 12 45 88))

;; Test Case 7: Test with a list containing multiple types (numbers and symbols)
(assert= (list-idempotent equalp (list 1 'a 2 'b 1 'a 2))
         (list 1 'a 2 'b))

;; Test Case 8: Test with a list of lists
(assert= (list-idempotent equalp (list (list 'a 'b) (list 'a 'b) (list 'c 'd)))
         (list (list 'a 'b) (list 'c 'd)))

;; Test Case 9: Test with a list of strings
(assert= (list-idempotent string-ci=p (list "foo" "bar" "foo" "baz"))
         (list "foo" "bar" "baz"))

;; Test Case 10: Test with a list of booleans
(assert= (list-idempotent equalp (list #t #t #f #f #t))
         (list #t #f #t))

;; Test Case 11: Test with many different types in the list
(assert= (list-idempotent equalp (list 1 "two" 'three 1 "two" 'three 'four))
         (list 1 "two" 'three 'four))

;; Test Case 12: Test with nested lists and deep equality
(assert= (list-idempotent equalp (list (list 1 (list 2)) (list 1 (list 2)) (list 3 (list 4))))
         (list (list 1 (list 2)) (list 3 (list 4))))

;; Test Case 13: Test where the predicate is always false
(assert= (list-idempotent (lambda (x y) 'skip) (list 1 2 3 1 2 3))
         (list 1 2 3 1 2 3))

;; Test Case 14: Test where the predicate is always true [1]
(assert= (list-idempotent (lambda (x y) 'left) (list 1 2 3 4 5 6 7))
         (list 1 3 5 7))

;; Test Case 15: Test where the predicate is always true [2]
(assert= (list-idempotent (lambda (x y) 'right) (list 1 2 3 4 5 6 7))
         (list 2 4 6 7))
