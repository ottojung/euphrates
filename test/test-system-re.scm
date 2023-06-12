

;; system-re

(let ()
  (assert= (cons "hello\n" 0) (system-re "echo hello"))
  (assert= (cons "hello\n" 0) (system-re "echo ~a" "hello")))
