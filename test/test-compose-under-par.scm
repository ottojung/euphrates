
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates compose-under-par)
           compose-under-par))
   (import (only (euphrates range) range))
   (import
     (only (scheme base)
           *
           +
           -
           begin
           cond-expand
           lambda
           let
           list
           map
           quote))))



(let () ;; compose-under-par
  (assert= (list 5 5 -5)
           ((compose-under-par list + * -) 5 5 5))
  (assert= '((2 0) (3 2) (4 4))
           (map (compose-under-par
                 list (lambda (x) (+ 2 x)) (lambda (x) (* 2 x)))
                (range 3) (range 3))))
