
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates shell-quote) shell-quote))
   (import
     (only (scheme base) begin cond-expand let))))


;; shell-quote

(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )
