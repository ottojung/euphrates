
(define (test result list-a list-b)
  (define elementwise-compare
    (lambda (a b)
      (clamp -1 1 (- a b))))

  (assert=
   result
   (list-compare elementwise-compare list-a list-b)))

(test 1 (list 1 2 3 4) (list 1 0 0 0))
(test -1 (list 1 2 3 4) (list 9 9 9 9))
(test 0 (list 1 2 3 4) (list 1 2 3 4))
(test 1 (list 1 2 3 4) (list 1 2))
(test -1 (list 1 2 3 4) (list 1 9))
(test 0 (list) (list))
(test 1 (list -29123) (list))
