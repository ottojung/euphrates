
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates linear-regression)
           linear-regression))
   (import
     (only (scheme base)
           begin
           call-with-values
           cond-expand
           define
           lambda
           let
           map
           quote))
   (import (only (scheme r5rs) exact->inexact))))


(define (LR x y)
  (call-with-values
      (lambda () (linear-regression x y))
    (lambda args (map exact->inexact args))))

(let ((x1 '(1 2 3 4 5))
      (y1 '(2 4 5 4 5))
      (expected1 '(0.6 2.2)))
  (assert= expected1 (LR x1 y1)))

(let ((x2 '(0 1 2 3 4))
      (y2 '(1 3 5 7 9))
      (expected2 '(2.0 1.0)))
  (assert= expected2 (LR x2 y2)))

(let ((x3 '(1 2 3))
      (y3 '(4 5 6))
      (expected3 '(1.0 3.0)))
  (assert= expected3 (LR x3 y3)))
