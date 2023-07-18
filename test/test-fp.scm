
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fp) fp))
   (import
     (only (euphrates list-zip-with) list-zip-with))
   (import (only (euphrates range) range))
   (import
     (only (scheme base)
           *
           +
           begin
           cond-expand
           let
           list
           map
           quote))))



(let () ;; fp
  (assert= '((0 2) (2 3) (4 4))
           (map (fp (x y) (list (* x 2) (+ y 2)))
                (list-zip-with list (range 3) (range 3)))))
