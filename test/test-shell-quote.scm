
(cond-expand
 (guile
  (define-module (test-shell-quote)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates shell-quote) :select (shell-quote)))))

;; shell-quote

(let ()
  (assert= "'$b'" (shell-quote "$b"))
  (assert= "'$'\"'\"'b'" (shell-quote "$'b"))
  (assert= "'$ '\"'\"' b'" (shell-quote "$ ' b"))
  )
