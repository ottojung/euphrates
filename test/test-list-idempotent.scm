
(assert= (list-idempotent equal? (list 1 2 1 4 1))
         (list 1 2 4))

(assert= (list-idempotent (lambda (x y)
                            (or (= (remainder x y) 0)
                                (= (remainder y x) 0)))
                          (list 2 5 4 3 10 15 7))
         (list 2 5 3 7))

;; (assert-throw (list-idempotent 0 1)) ;; type error
