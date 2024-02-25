
(assert= (list-annihilate equal? (list 1 2 1 4 1))
         (list 2 4 1))

(assert-throw #t (list-annihilate 1 2)) ;; type error

;; Test identical numbers
(assert= (list-annihilate equal? (list 1 2 3 2 1))
         (list 3))

;; Constant in the original list.
(assert= (list-annihilate (lambda (x y) (equal? x 'c))
                          (list 1 2 'c 4 5))
         '(1 2 5))

;; Non symmetric [1].
(assert= (list-annihilate (lambda (x y) (equal? x 9))
                          (list 7 8 9 6 5))
         '(7 8 5))

;; Non symmetric [2].
(assert= (list-annihilate (lambda (x y) (equal? 9 y))
                          (list 7 8 9 6 5))
         '(8 6 5))

;; Non recursive.
(assert= (list-annihilate
          (lambda (x y)
            (or (equal? x y)
                (equal? x 'c)
                (equal? y 'c)))

          (list 1 2 1 4 1))
         (list 2 4 1))

;; Test with pairs (cons cells) and equal?
(assert= (list-annihilate equal? (list (cons 1 2) (cons 1 2) (cons 3 4)))
         (list (cons 3 4)))

;; Test with an empty list
(assert= (list-annihilate equal? '())
         '())

;; Test list with a single element
(assert= (list-annihilate equal? (list 1))
         (list 1))

;; Test list with only identical elements
(assert= (list-annihilate equal? (list 1 1 1 1))
         '())

;; Test list with no matching elements
(assert= (list-annihilate equal? (list 1 2 3 4))
         (list 1 2 3 4))

;; Test list with non-numeric elements
(assert= (list-annihilate equal? (list 'a 'b 'c 'd))
         (list 'a 'b 'c 'd))

;; Test with different types in one list
(assert= (list-annihilate equal? (list 1 'a 1.0 "string"))
         (list 1 'a 1.0 "string"))

;; Test using `=` predicate with numbers
(assert= (list-annihilate = (list 2 3 2 5 2))
         (list 3 5 2))

;; Test with strings using `string=?` predicate
(assert= (list-annihilate string=? (list "apple" "banana" "apple" "cherry"))
         (list "banana" "cherry"))

;; Test list containing sublists
(assert= (list-annihilate equal? (list (list 1 2) (list 3 4) (list 1 2)))
         (list (list 3 4)))

;; Test with elements of different data types using `equal?` predicate
(assert= (list-annihilate equal? (list 1 'a 2 'b))
         (list 1 'a 2 'b))

;; Test entire list removed due to custom predicate always returning true
(assert= (list-annihilate (lambda (a b) #t) (list 1 2 3 4))
         '())

;; Test with characters
(assert= (list-annihilate char=? (list #\a #\b #\a))
         (list #\b))

;; Test with vectors
(assert= (list-annihilate equal? (list #(1 2) #(3 4) #(1 2)))
         (list #(3 4)))

;; Test list containing different boolean values
(assert= (list-annihilate equal? (list #t #f #t))
         (list #f))

;; Test using a predicate that checks for even numbers
(assert= (list-annihilate (lambda (x y) (and (even? x) (even? y))) (list 2 3 4 6))
         (list 3 6))

;; Test if function does not mutate the original list
(define original-list (list 1 2 3 2 1))
(define processed-list (list-annihilate equal? original-list))
(assert= processed-list (list 3))
(assert= original-list (list 1 2 3 2 1))

;; Test with a mix of symbols and numbers
(assert= (list-annihilate equal? (list 'foo 42 'foo 13))
         (list 42 13))
