
(cond-expand
 (guile
  (define-module (test-system-re)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates system-re) :select (system-re)))))

;; system-re

(let ()
  (assert= (cons "hello\n" 0) (system-re "echo hello"))
  (assert= (cons "hello\n" 0) (system-re "echo ~a" "hello")))
