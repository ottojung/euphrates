(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'found) (values))) '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'found) (values))) '(a a b b))
         (list 'found 'found))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (> x 2) (values 'hit) (values))) '(1 2 3 4 5 6 7))
         (list 'hit 'hit 'hit 7))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (string=? x "hello") (values 'present) (values))) '("apple" "banana" "cherry" "hello" "apple"))
         (list 'present "banana" "cherry" "apple"))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (= (modulo x 2) 0) (values 2) (values))) '(1 2 3 4 5 6))
         (list 2 2 2))

(assert= (list-reduce/pairwise (lambda (direction x y) (if (and (equal? direction 'forward) (> x 2)) (values 'hit) (values))) '(1 2 3 4 5 6 7))
         (list 1 2 'hit 'hit 7))
