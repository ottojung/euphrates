

;; shell-quote

(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )
