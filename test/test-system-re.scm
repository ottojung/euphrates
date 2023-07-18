
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates system-re) system-re))
   (import
     (only (scheme base) begin cond-expand cons let))))


;; system-re

(let ()
  (assert= (cons "hello\n" 0) (system-re "echo hello"))
  (assert= (cons "hello\n" 0) (system-re "echo ~a" "hello")))
