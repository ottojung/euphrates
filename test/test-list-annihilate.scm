
(assert= (list-annihilate equal? 'c (list 1 2 1 4 1))
         (list 1 2 4))

(assert-throw #t (list-annihilate 0 1 2)) ;; type error
