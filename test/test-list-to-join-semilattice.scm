
(define (test-case equality-tester join-function lst expected)
  (define result
    (list->join-semilattice
     equality-tester
     join-function
     lst))

  (debugs result)

  (define actual
    (map olnode->list
         (olgraph:initial result)))

  (debugs actual)

  (assert= actual expected))

(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(1 2 3 4 5)

 '((1)
   (2 (1))
   (3 (1))
   (4 (2 (1)) (1))
   (5 (1)))

 )

(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(1 2 3 4 5 6 7 8 9 10 11 12)

 '((1)
   (2 (1))
   (3 (1))
   (4 (2 (1)) (1))
   (5 (1))
   (6 (3 (1)) (2 (1)) (1))
   (7 (1))
   (8 (4 (2 (1)) (1)) (2 (1)) (1))
   (9 (3 (1)) (1))
   (10 (5 (1)) (2 (1)) (1))
   (11 (1))
   (12
    (6 (3 (1)) (2 (1)) (1))
    (4 (2 (1)) (1))
    (3 (1))
    (2 (1))
    (1)))


 )





(test-case
 (lambda (x y)
   (hashset-equal?
    (list->hashset x)
    (list->hashset y)))

 (lambda (x y) (list-intersect x y))

 '((1 2 3) (1 2 6))

 '(((1 2 3) ((1 2)))
   ((1 2 6) ((1 2))))

 )




(test-case
 (lambda (x y)
   (hashset-equal?
    (list->hashset x)
    (list->hashset y)))

 (lambda (x y) (list-intersect x y))

 '((1 2 3) (1 2 6) (1 5 6) (1 7))

 0

 )


