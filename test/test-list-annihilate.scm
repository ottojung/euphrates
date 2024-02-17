
(assert= (list-annihilate equal? 'c (list 1 2 1 4 1))
         (list 'c 2 'c 4 'c))

(assert-throw #t (list-annihilate 0 1 2)) ;; type error

(assert= (list-annihilate = 'x (list 1 2 3 2 1))
         (list 'x 2 3 'x 'x))
