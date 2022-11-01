
%run guile

;; lazy-parameter, with-dynamic
%use (assert=) "./src/assert-equal.scm"
%use (lazy-parameter) "./src/lazy-parameter.scm"
%use (~a) "./src/tilda-a.scm"
%use (with-dynamic) "./src/with-dynamic.scm"

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
