
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-partition) list-partition))
   (import (only (euphrates range) range))
   (import
     (only (scheme base)
           begin
           cond-expand
           even?
           let
           quote))))



(let () ;; list-partition
  (assert= '((#t 8 6 4 2 0)
             (#f 9 7 5 3 1))
           (list-partition even? (range 10))))
