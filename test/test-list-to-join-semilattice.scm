
(define (test-case equality-tester join-function lst expected)
  (define actual
    (list->join-semilattice
     equality-tester
     join-function
     lst))

  (assert= actual expected))


(test-case
 equal?
 (lambda (x y)
   