
;; Test case: Normal operation
(assert= '(1 3) (list-intersect '(1 2 3) '(3 1 4))) ; Lists have common elements
(assert= '(1) (list-intersect '(1 2 3) '(1 4 5))) ; Lists have a single common element
(assert= '() (list-intersect '(1 2 3) '(4 5 6))) ; Lists have no common elements

;; Test case: Boundary conditions
(assert= '(1 2 3) (list-intersect '(1 2 3) '(1 2 3))) ; Lists are identical
(assert= '(1 2 3) (list-intersect '(1 2 3 1 2 3) '(1 2 3))) ; List A contains repetitions of B
(assert= '(1 2 3 1 2 3) (list-intersect '(1 2 3 1 2 3) '(1 2 3 1 2 3))) ; Both lists contain identical repetitions
(assert= '() (list-intersect '() '(1 2 3))) ; List A is empty
(assert= '() (list-intersect '(1 2 3) '())) ; List B is empty
(assert= '() (list-intersect '() '())) ; Both lists are empty

;; Test case: Invalid inputs
(assert-throw #t (list-intersect '(1 2 3) 'not-a-list)) ; B isn't a list
(assert-throw #t (list-intersect 'not-a-list '(1 2 3))) ; A isn't a list
(assert-throw #t (list-intersect 'not-a-list 'also-not-a-list)) ; Neither A nor B is a list
