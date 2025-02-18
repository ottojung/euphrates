
(let ()
  (assert= (list-take-until even? '(1 2 3 4)) '(1 2)))

(let ()
  (assert= (list-take-until even? '(1 3 5 7 8 3 4)) '(1 3 5 7 8)))

(let ()
  (assert= (list-take-until even? '(1 3 5 7 8 4 3)) '(1 3 5 7 8)))

(let ()
  (assert= (list-take-until even? '(2 3 4)) '(2)))

(let ()
  (assert= (list-take-until even? '(1 3 5 7)) '(1 3 5 7)))

(let ()
  (assert= (list-take-until even? '()) '()))
