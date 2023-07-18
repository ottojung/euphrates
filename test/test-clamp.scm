
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates clamp) clamp))
   (import (only (scheme base) begin cond-expand))))

(assert= 0.5 (clamp 0 1 0.5))
(assert= 1 (clamp 0 1 7))
(assert= 0 (clamp 0 1 -2)) ; x is lower than the range, should return the lower bound
(assert= 1 (clamp 0 1 2)) ; x is higher than the range, should return the upper bound
(assert= -5 (clamp -5 5 -10)) ; x is lower than the range, with negative bounds
(assert= 5 (clamp -5 5 10)) ; x is higher than the range, with negative bounds
(assert= 5 (clamp 5 5 3)) ; x is within the range, with equal bounds
(assert= 0 (clamp 0 0 0)) ; x is within the range, with equal bounds as zero
(assert= 5 (clamp 5 5 7)) ; x is higher than the range, with equal bounds
(assert= 0 (clamp 0 0 5)) ; x is lower than the range, with equal bounds as zero
(assert= 0 (clamp 0 1 0)) ; x is equal to the lower bound, should return the lower bound
(assert= 1 (clamp 0 1 1)) ; x is equal to the upper bound, should return the upper bound
