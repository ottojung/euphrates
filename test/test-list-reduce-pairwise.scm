
(assert= (list-reduce/pairwise 'not-found (lambda (x y) (if (equal? x y) 'found 'not-found)) '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise 'default (lambda (x y) (if (> x 2) 'hit 'default)) '(1 2 3 4 5 6 7))
         (list 1 2 'hit 'hit 7))

(assert= (list-reduce/pairwise 'missing (lambda (x y) (if (string=? x "hello") 'present 'missing)) '("apple" "banana" "cherry" "hello" "apple"))
         (list "apple" "banana" "cherry" 'present))

;; (assert= (list-reduce/pairwise 0 (lambda (x y) (if (= (modulo x 2) 0) 2 0)) '(1 2 3 4 5 6))
;;          (list 1 2 3 4))

;; (assert= (list-reduce/pairwise 'null (lambda (x y) (if (null? x) 'nil 'null)) '(() a b c ()))
;;          (list 'nil a b c))

(assert-throw #t (list-reduce/pairwise 0 (lambda (x y) (+ x y)) 0)) ;; type error

;; (assert= (list-reduce/pairwise 'nil (lambda (x y) (if (and (number? x) (number? y)) x 'nil)) '(1 2 "three" 4))
;;          (list 1 "three" 4))

;; ;; Test with an empty list
;; (assert= (list-reduce/pairwise 'none found? '())
;;          (list))

;; Test list with a single element
(assert= (list-reduce/pairwise 'empty found? (list 'only-ele))
         (list 'only-ele))

;; Test list with duplicates
(assert= (list-reduce/pairwise 'missing (lambda (x y) (if (equal? x y) 'found 'missing)) '(1 2 2 3 3 4 4))
         (list 'found 'found 'found))

;; Test list containing sublists
(assert= (list-reduce/pairwise 'default (lambda (x y) (if (equal? x y) 'hit 'default)) '((1 2) (3 4) (1 2)))
         (list 'hit (list 3 4)))

;; ;; Test with elements of different data types
;; (assert= (list-reduce/pairwise 'default (lambda (x y) (if (char-alphabetic? x) 'yes 'default)) '(#\a 2 #\b "string" 3.14159 (2 . 3)))
;;          (list 'yes 2 #\b "string" 3.14159 (2 . 3)))

;; ;; Test with a list of different types of pairs
;; (assert= (list-reduce/pairwise 'no-match (lambda (x y) (if (equal? x y) 'match 'no-match)) '((1 . "one") (1 . 2) (1 . "one") (2 . "two") (1 . 2)))
;;          (list 'match (1 . 2) 'match (2 . "two")))

;; Test with a list of different types of pairs and `equal` predicate
(assert= (list-reduce/pairwise 'mismatch (lambda (x y) (if (equal? x y) 'match 'mismatch)) '((1 . 2) "pair" (1 . 2) "not pair" (1 . 2)))
         (list 'match "pair" "not pair" (cons 1 2)))
