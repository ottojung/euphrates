
(assert= (list-idempotent equal? (list 1 2 1 4 1))
         (list 1 2 4))

