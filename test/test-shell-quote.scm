
%run guile

;; shell-quote
%use (assert=) "./src/assert-equal.scm"
%use (shell-quote) "./src/shell-quote.scm"

(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )
