
%run guile

;; shell-quote
%use (assert=) "./euphrates/assert-equal.scm"
%use (shell-quote) "./euphrates/shell-quote.scm"

(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )
