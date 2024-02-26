
(define (test-case equality-tester join-function lst expected)
  (define result
    (list->join-semilattice
     equality-tester
     join-function
     lst))

  (define actual
    (olgraph->adjlist result))

  (debugs actual)

  (assert= actual expected))



(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(1 2 3 4 5)

 '((1)
   (2 1)
   (3 1)
   (4 2)
   (5 1))

 )



(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(1 2 3 4 5 6 7 8 9 10 11 12)

 '((1)
   (2 1)
   (3 1)
   (4 2)
   (5 1)
   (6 3 2)
   (7 1)
   (8 4)
   (9 3)
   (10 5 2)
   (11 1)
   (12 6 4))

 )





(test-case
 (lambda (x y)
   (hashset-equal?
    (list->hashset x)
    (list->hashset y)))

 (lambda (x y) (list-intersect x y))

 '((1 2 3) (1 2 6))

 '(((1 2 3) (1 2))
   ((1 2))
   ((1 2 6) (1 2)))

 )




(test-case
 (lambda (x y)
   (hashset-equal?
    (list->hashset x)
    (list->hashset y)))

 (lambda (x y) (list-intersect x y))

 '((1 2 3) (2 6 1) (5 1 6) (7 1))

 '(((1 2 3) (1 2))
   ((1 2) (1))
   ((1))
   ((2 6 1) (6 1) (1 2))
   ((6 1) (1))
   ((5 1 6) (6 1))
   ((7 1) (1)))

 )



(test-case
 (lambda (x y)
   (hashset-equal?
    (list->hashset x)
    (list->hashset y)))

 (lambda (x y)
   (let ((r (list-intersect x y)))
     (if (null? r) (values) r)))

 '((1 2 3) (2 6 1) (5 1 6) (7 1) (5))

 '(((1 2 3) (1 2))
   ((1 2) (1))
   ((1))
   ((2 6 1) (6 1) (1 2))
   ((6 1) (1))
   ((5 1 6) (5) (6 1))
   ((5))
   ((7 1) (1)))

 )



(test-case
 (lambda (x y)
   (hashset-equal?
    (list->hashset x)
    (list->hashset y)))

 (lambda (x y) (list-union x y))

 '((1 2) (2 1) (5 1) (7 1 5))

 '(((1 2) ((1 2 5)))
   ((2 1) ((1 2)))
   ((5 1) ((7 1 5)) ((1 2 5)))
   ((7 1 5) ((1 2 7 5))))

 )
