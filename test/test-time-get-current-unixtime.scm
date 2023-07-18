
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates time-get-current-unixtime)
           time-get-current-unixtime))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           number?))))


;; time-get-current-unixtime

(let ()
  (assert (number? (time-get-current-unixtime))))

