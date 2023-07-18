
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates stringf) stringf))
   (import
     (only (scheme base) begin cond-expand let))))


(let ()
  (assert= "start 1 2 3 end"
           (stringf "start ~s 2 ~a end"
                    1 3)))
