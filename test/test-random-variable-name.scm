
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates random-variable-name)
           random-variable-name))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           let
           string-length))
   (import (only (scheme char) string-downcase))))



(let () ;; random-variable-name
  (define n1 (random-variable-name 20))
  (assert= 20 (string-length n1))
  (assert= n1 (string-downcase n1))
  )
