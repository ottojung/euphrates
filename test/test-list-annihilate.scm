
(assert= (list-annihilate equal? 'c (list 1 2 1 4 1))
         (list 1 2 4))

(assert= (list-annihilate (lambda (x y)
                            (or (= (remainder x y) 0)
                                (= (remainder y x) 0)))
                          (list 2 5 4 3 10 15 7))
         (list 2 5 3 7))

(assert-throw #t (list-annihilate 0 1 2)) ;; type error
