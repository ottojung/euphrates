
(assert= '((1 1 1 1 1 1 1) (2 2) (3 3) (4 4))
         (list-get-duplicates '(1 2 3 1 4 1 2 3 1 1 4 1 1)))

(assert= '((1 1 1 1 1 1 1) (2 2) (3 3))
         (list-get-duplicates '(1 2 3 1 1 2 3 1 1 4 1 1)))

(assert= '((1 1 1 1 1 1 1))
         (list-get-duplicates '(1 2 1 1 3 1 1 4 1 1)))

(assert= '()
         (list-get-duplicates '(2 1 3 4)))

(assert= '()
         (list-get-duplicates '()))

(assert= '((1 3 1 1 3 1 1 1 1) (2 4 2 4))
         (list-get-duplicates '(1 2 3 1 4 1 2 3 1 1 4 1 1) even?))

(assert= '((1 3 1 1 3 1 1 1 1))
         (list-get-duplicates '(1 3 1 1 3 1 1 4 1 1) even?))
