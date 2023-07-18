
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fn-cons) fn-cons))
   (import
     (only (euphrates list-zip-with) list-zip-with))
   (import (only (euphrates range) range))
   (import
     (only (scheme base)
           *
           +
           -
           begin
           car
           cond-expand
           cons
           expt
           lambda
           let
           map
           quote))))



(let () ;; fn-cons
  (assert= '((0 . 2) (2 . 3) (4 . 4))
           (map (fn-cons (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with cons (range 3) (range 3))))
  (assert= (cons 5 (cons 8 25))
           ((fn-cons (lambda (x) (+ x 2))
                     (lambda (x) (* x 2))
                     (lambda (x) (expt (car x) 2)))
            (cons 3 (cons 4 (cons 5 6)))))
  (assert= (cons 5 (cons 8 (cons 25 4)))
           ((fn-cons (lambda (x) (+ x 2))
                     (lambda (x) (* x 2))
                     (lambda (x) (expt x 2))
                     (lambda (x) (- x 2)))
            (cons 3 (cons 4 (cons 5 6))))))
