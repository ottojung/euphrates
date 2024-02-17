
(assert= (list-annihilate equal? 'c (list 1 2 1 4 1))
         (list 'c 2 'c 4 'c))

(assert-throw #t (list-annihilate 0 1 2)) ;; type error

;; Test identical numbers
(assert= (list-annihilate equal? 'x (list 1 2 3 2 1))
         (list 'x 'x 3 'x 'x))

;; Constant in the original list.
(assert= (list-annihilate (lambda (x y) (equal? x 'c))
                          'c (list 1 2 'c 4 5))
         '(1 2 c c c))

;; Non symmetric.
(assert= (list-annihilate (lambda (x y) (equal? x 2))
                          'c (list 1 2 3 4 5))
         '(1 c c c c))

(exit 0)

;; ;; Non recursive.
;; (assert= (list-annihilate
;;           (lambda (x y)
;;             (or (equal? x y)
;;                 (equal? x 'c)
;;                 (equal? y 'c)))

;;           'c (list 1 2 1 4 1))
;;          (list 'c 2 1 4 1))

;; ;; Test with pairs (cons cells) and equal?
;; (assert= (list-annihilate equal? 'same (list (cons 1 2) (cons 1 2) (cons 3 4)))
;;          (list 'same 'same (cons 3 4)))

;; Test with an empty list
(assert= (list-annihilate equal? 'c '())
         '())

;; Test list with a single element
(assert= (list-annihilate equal? 'c (list 1))
         (list 1))

;; Test list with only identical elements
(assert= (list-annihilate equal? 'annihilated (list 1 1 1 1))
         (list 'annihilated 'annihilated 'annihilated 'annihilated))

;; Test list with no matching elements
(assert= (list-annihilate equal? 'n (list 1 2 3 4))
         (list 1 2 3 4))

;; Test list with non-numeric elements
(assert= (list-annihilate equal? 'same (list 'a 'b 'c 'd))
         (list 'a 'b 'c 'd))

;; Test with different types in one list
(assert= (list-annihilate equal? 'different (list 1 'a 1.0 "string"))
         (list 1 'a 1.0 "string"))

;; Test using `=` predicate with numbers
(assert= (list-annihilate = 0 (list 2 3 2 5 2))
         (list 0 3 0 5 0))

;; Test with strings using `string=?` predicate
(assert= (list-annihilate string=? 'same (list "apple" "banana" "apple" "cherry"))
         (list 'same "banana" 'same "cherry"))

;; Test list containing sublists
(assert= (list-annihilate equal? 'sublist (list (list 1 2) (list 3 4) (list 1 2)))
         (list 'sublist (list 3 4) 'sublist))

;; Test with elements of different data types using `equal?` predicate
(assert= (list-annihilate equal? 'type-mismatch (list 1 'a 2 'b))
         (list 1 'a 2 'b))

;; Test entire list replaced due to custom predicate always returning true
(assert= (list-annihilate (lambda (a b) #t) 'true (list 1 2 3 4))
         (list 'true 'true 'true 'true))

;; Test with characters
(assert= (list-annihilate char=? 'char-same (list #\a #\b #\a))
         (list 'char-same #\b 'char-same))

;; Test with vectors
(assert= (list-annihilate equal? 'vec-same (list #(1 2) #(3 4) #(1 2)))
         (list 'vec-same #(3 4) 'vec-same))

;; Test list containing different boolean values
(assert= (list-annihilate equal? 'bool (list #t #f #t))
         (list 'bool #f 'bool))

;; Test using a predicate that checks for even numbers
(assert= (list-annihilate (lambda (x y) (and (even? x) (even? y))) 'even-pair (list 2 3 4 6))
         (list 'even-pair 3 'even-pair 'even-pair))

;; Test if function does not mutate the original list
(define original-list (list 1 2 3 2 1))
(define processed-list (list-annihilate equal? 'x original-list))
(assert= original-list (list 1 2 3 2 1))

;; Test with a mix of symbols and numbers
(assert= (list-annihilate equal? 'symbol (list 'foo 42 'foo 13))
         (list 'symbol 42 'symbol 13))
