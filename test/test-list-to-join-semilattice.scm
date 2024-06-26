
(define-syntax test-case
  (syntax-rules ()
    ((_ equality-tester join-function lst expected)
     (let ()
       (define result
         (list->join-semilattice
          equality-tester
          join-function
          lst))

       (define actual
         (olgraph->adjlist result))

       (assert= actual expected)))))



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
   (10 2 5)
   (11 1)
   (12 4 6))

 )





(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(2 3 4 5)

 '((2 1)
   (1)
   (3 1)
   (4 2)
   (5 1))

 )



(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(3 4 5)

 '((3 1)
   (1)
   (4 1)
   (5 1))

 )



(test-case
 equal?
 (lambda (x y)
   (greatest-common-divisor x y))

 '(3 4 5 6)

 '((3 1)
   (1)
   (4 2)
   (2 1)
   (5 1)
   (6 3 2))

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
   ((2 6 1) (1 2) (6 1))
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
   ((2 6 1) (1 2) (6 1))
   ((6 1) (1))
   ((5 1 6) (6 1) (5))
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

 '(((1 2) (1 2 5))
   ((1 2 5) (1 2 7 5))
   ((1 2 7 5))
   ((2 1) (1 2))
   ((5 1) (1 2 5) (7 1 5))
   ((7 1 5) (1 2 7 5)))

 )




(test-case
 equal?
 (lambda (x y)
   (min (+ x y) 9))

 '(3 4 9)

 '((3 7) (7 9) (9) (4 7))

 )
