
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates mdict)
           mdict
           mdict-has?
           mdict-set!))
   (import
     (only (scheme base) begin cond-expand let not))))


;; mdict

(let ((zz (mdict 1 2
                 3 4)))
  (assert= (zz 3)
           4)
  (let ((z2 (zz 3 99)))
    (assert= (z2 3)
             99)
    (assert (mdict-has? z2 3))
    (assert (not (mdict-has? z2 52)))
    (let ((z3 (z2 52 2)))
      (assert (mdict-has? z3 52))
      (mdict-set! z3 52 9)
      (assert= (z3 52) 9))))

