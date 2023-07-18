
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates fn) fn))
   (import
     (only (scheme base) begin cond-expand let list))))



(let () ;; fn
  (assert= (list 1 2 3)
           ((fn list 1 % 3) 2)))
