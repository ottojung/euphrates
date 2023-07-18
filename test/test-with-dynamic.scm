
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates lazy-parameter) lazy-parameter))
   (import (only (euphrates tilda-a) ~a))
   (import
     (only (euphrates with-dynamic) with-dynamic))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           lambda
           make-parameter
           set!
           string->number))))


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
