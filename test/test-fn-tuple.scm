
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fn-tuple) fn-tuple))
   (import
     (only (euphrates list-zip-with) list-zip-with))
   (import (only (euphrates range) range))
   (import
     (only (scheme base)
           *
           +
           begin
           cond-expand
           lambda
           let
           list
           map
           quote))))



(let () ;; fn-tuple
  (assert= '((0 2) (2 3) (4 4))
           (map (fn-tuple (lambda (x) (* x 2)) (lambda (x) (+ x 2)))
                (list-zip-with list (range 3) (range 3)))))
