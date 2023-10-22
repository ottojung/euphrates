
(assert= 10 (list-fold/semigroup + '(1 2 3 4))) ;; expected behavior with addition function
(assert= 24 (list-fold/semigroup * '(1 2 3 4))) ;; expected behavior with multiplication function
(assert= 5 (list-fold/semigroup + '(5))) ;; folding a one element list
(assert= "hello world" (list-fold/semigroup string-append '("hello" " " "world"))) ;; concatenating strings
(assert-throw 'empty-input-list (list-fold/semigroup + '())) ;; folding an empty list should throw an "illegal-argument" error
(assert-throw #t (list-fold/semigroup + 5)) ;; passing a non-list as 'lst' should throw an "illegal-argument" error
(assert-throw #t (list-fold/semigroup string-append '(1 2 3 4))) ;; passing a function and list that are incompatible should throw a "type-error" error
