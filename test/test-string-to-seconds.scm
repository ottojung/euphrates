
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates string-to-seconds)
           string->seconds))
   (import (only (scheme base) begin cond-expand))))

(assert= 20 (string->seconds "20s"))
(assert= 80 (string->seconds "1m20s"))
(assert= 20 (string->seconds "20"))
