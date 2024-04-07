
(assert= (list-reduce/pairwise
          (lambda (d x y) (if (equal? x y) 'found (values)))
          '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise
          (lambda (d x y) (if (equal? x y) 'found (values)))
          '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise
          (lambda (d x y) (if (> x 2) 'hit (values)))
          '(1 2 3 4 5 6 7))
         (list 'hit 'hit 'hit 7))

(assert= (list-reduce/pairwise
          (lambda (d x y) (if (and (equal? d 'forward) (> x 2)) 'hit (values)))
          '(1 2 3 4 5 6 7))
         (list 1 2 'hit 'hit 7))

(assert= (list-reduce/pairwise
          (lambda (d x y) (if (and (equal? d 'reverse) (> x 2)) 'hit (values)))
          '(1 2 3 4 5 6 7))
         (list 'hit 'hit 'hit 7))

(assert= (list-reduce/pairwise
          (lambda (d x y) (if (string=? x "hello") 'present (values)))
          '("apple" "banana" "cherry" "hello" "apple"))
         '(         "banana" "cherry" present "apple"))

(assert= (list-reduce/pairwise (lambda (d x y) (if (= (modulo (+ x y) 2) 0) 0 (values))) '(1 2 3 4 5 6))
         (list 0 0 5 6))

(define (agrees fun input)
  (assert= (list-reduce/pairwise/left fun input)
           (list-reduce/pairwise (lambda (d x y) (if (equal? d 'forward) (fun x y) (values))) input)))

(agrees (lambda (x y) (if (equal? x y) 'found (values))) '(a a b b))

(agrees (lambda (x y) (if (> x 2) 'hit (values))) '(1 2 3 4 5 6 7))

(agrees (lambda (x y) (if (string=? x "hello") 'present (values))) '("apple" "banana" "cherry" "hello" "apple"))

(agrees (lambda (x y) (if (= (modulo x 2) 0) 2 (values))) '(1 2 3 4 5 6))

(agrees (lambda (x y) (if (null? x) 'nil (values))) '(() a b c ()))

(assert-throw #t (agrees (lambda (x y) (+ x y)) 0)) ;; type error

(agrees (lambda (x y) (if (and (number? x) (number? y)) x (values))) '(1 2 "three" 4))

;; Test with an empty list
(agrees (lambda _ (values)) '())

;; Test list with a single element
(agrees (lambda _ (values)) (list 'only-ele))

;; Test list with duplicates
(agrees (lambda (x y) (if (equal? x y) 'found (values))) '(1 2 2 3 3 4 4))

;; Test list containing sublists
(agrees (lambda (x y) (if (equal? x y) 'hit (values))) '((1 2) (3 4) (1 2)))

;; Test with elements of different data types
(agrees (lambda (x y) (if (char? x) 'yes (values))) '(#\a 2 #\b "string" 3.14159 (2 . 3)))

;; Test with a list of different types of pairs and `equal` predicate
(agrees (lambda (x y) (if (equal? x y) 'match (values))) '((1 . 2) "pair" (1 . 2) "not pair" (1 . 2)))
