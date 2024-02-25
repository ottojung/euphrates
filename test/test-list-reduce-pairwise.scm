(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'found) (values))) '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'found) (values))) '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (> x 2) (values 'hit) (values))) '(1 2 3 4 5 6 7))
         (list 'hit 'hit 'hit 7))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (string=? x "hello") (values 'present) (values))) '("apple" "banana" "cherry" "hello" "apple"))
         (list 'present "banana" "cherry" "apple"))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (= (modulo x 2) 0) (values 2) (values))) '(1 2 3 4 5 6))
         (list 1 2 2 6))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (null? x) (values 'nil) (values))) '(() a b c ()))
         (list 'nil 'b 'c (list)))

(assert-throw #t (list-reduce/pairwise (lambda (direction x y) (+ x y)) 0)) ;; type error

(assert= (list-reduce/pairwise (lambda (direction x y) (if (and (number? x) (number? y)) (values x) (values))) '(1 2 "three" 4))
         (list 1 "three" 4))

;; Test with an empty list
(assert= (list-reduce/pairwise (lambda (direction x y) (values)) '())
         (list))

;; Test list with a single element
(assert= (list-reduce/pairwise (lambda (direction x y) (values)) (list 'only-ele))
         (list 'only-ele))

;; Test list with duplicates
(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'found) (values))) '(1 2 2 3 3 4 4))
         (list 1 'found 'found 'found))

;; Test list containing sublists
(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'hit) (values))) '((1 2) (3 4) (1 2)))
         (list 'hit (list 3 4)))

;; Test with elements of different data types
(assert= (list-reduce/pairwise (lambda (direction x y) (if (char? x) (values 'yes) (values))) '(#\a 2 #\b "string" 3.14159 (2 . 3)))
         (list 'yes 'yes 3.14159 (cons 2  3)))

;; Test with a list of different types of pairs and `equal` predicate
(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'match) (values))) '((1 . 2) "pair" (1 . 2) "not pair" (1 . 2)))
         (list 'match "pair" "not pair" (cons 1 2)))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (and (equal? direction 'forward) (> x 2)) (values 'hit) (values))) '(1 2 3 4 5 6 7))
         (list 1 2 'hit 'hit 7))
