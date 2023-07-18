
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates time-to-string)
           seconds->time-string))
   (import
     (only (scheme base) * + begin cond-expand let))))


;; seconds->time-string

(let ()
  (assert= "2:01:10" (seconds->time-string (+ (* 3600 2) 70))))
