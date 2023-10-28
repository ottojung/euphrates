
(assert= 10 (list-fold/right/semigroup + '(1 2 3 4))) ;; expected behavior with addition function
(assert= 24 (list-fold/right/semigroup * '(1 2 3 4))) ;; expected behavior with multiplication function
(assert= "hello world" (list-fold/right/semigroup string-append '("hello" " " "world"))) ;; concatenating strings
(assert= '(1 (2 (3 4))) (list-fold/right/semigroup list '(1 2 3 4))) ;; expected behavior with non-associative function
(assert= 5 (list-fold/right/semigroup + '(5))) ;; folding a one element list
(assert-throw 'empty-input-list (list-fold/right/semigroup + '())) ;; folding an empty list should throw an "illegal-argument" error
(assert-throw #t (list-fold/right/semigroup + 5)) ;; passing a non-list as 'lst' should throw an "illegal-argument" error
(assert-throw #t (list-fold/right/semigroup string-append '(1 2 3 4))) ;; passing a function and list that are incompatible should throw a "type-error" error
