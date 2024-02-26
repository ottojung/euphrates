
(define (test-case equality-tester join-function lst expected)
  (define result
    (list->join-semilattice
     equality-tester
     join-function
     lst))

  (define actual
    (map olnode->list
         (olgraph:initial result)))

  (assert= actual expected))

(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(1 2 3 4 5)

 '((1)
   (2 (1))
   (3 (1))
   (4 (1) (2 (1)))
   (5 (1))))
