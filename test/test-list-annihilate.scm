
(assert= (list-annihilate equal? 'c (list 1 2 1 4 1))
         (list 'c 2 'c 4 'c))

(assert-throw #t (list-annihilate 0 1 2)) ;; type error

;; Test identical numbers
(assert= (list-annihilate equal? 'x (list 1 2 3 2 1))
         (list 'x 'x 3 'x 'x))

;; Test with pairs (cons cells) and equal?
(assert= (list-annihilate equal? 'same (list (cons 1 2) (cons 1 2) (cons 3 4)))
         (list 'same 'same (cons 3 4)))

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
