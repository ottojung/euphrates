
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fn-pair) fn-pair))
   (import
     (only (euphrates list-zip-with) list-zip-with))
   (import (only (euphrates range) range))
   (import
     (only (scheme base)
           *
           +
           begin
           cond-expand
           cons
           map
           quote))))



(assert= '((0 . 2) (2 . 3) (4 . 4))
         (map (fn-pair (a b) (cons (* a 2) (+ b 2)))
              (list-zip-with cons (range 3) (range 3))))
