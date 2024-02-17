
(assert= (list-annihilate equal? 'c (list 1 2 1 4 1))
         (list 'c 2 'c 4 'c))

(assert-throw #t (list-annihilate 0 1 2)) ;; type error

;; Test identical numbers
(assert= (list-annihilate equal? 'x (list 1 2 3 2 1))
         (list 'x 'x 3 'x 'x))

;; Test with pairs (cons cells) and equal?
(assert= (list-annihilate equal? 'same (list (cons 1 2) (cons 1 2) (cons 3 4)))
         (list 'same 'same (cons 3 4)))
