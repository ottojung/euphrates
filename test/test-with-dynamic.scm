
(cond-expand
 (guile
  (define-module (test-with-dynamic)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates lazy-parameter) :select (lazy-parameter))
    :use-module ((euphrates tilda-a) :select (~a))
    :use-module ((euphrates with-dynamic) :select (with-dynamic)))))

;; lazy-parameter, with-dynamic

(define test 1)
(define x (lazy-parameter (begin (set! test 3) 2)
                          (lambda (z) (string->number (~a z)))))
(define y (make-parameter 9))

(assert= test 1)
(assert= (y) 9)

(with-dynamic ((x 4) (y 5))
              (assert= (y) 5)
              (assert= (x) 4)
              (assert= test 1))

(assert= test 1)
(assert= (x) 2)
(assert= test 3)
