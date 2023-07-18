
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates string-trim-chars)
           string-trim-chars))
   (import
     (only (scheme base)
           begin
           cond-expand
           define
           let*
           quote))))


;; string-trim-chars

(let* ((s "xxhellokh")
       (tt "hx"))
  (define (test mode) (string-trim-chars s tt mode))

  (assert= "ellokh" (test 'left))
  (assert= "xxhellok" (test 'right))
  (assert= "ellok" (test 'both)))
