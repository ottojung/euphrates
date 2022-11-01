
%run guile

;; system-re
%use (assert=) "./src/assert-equal.scm"
%use (system-re) "./src/system-re.scm"

(let ()
  (assert= (cons "hello\n" 0) (system-re "echo hello"))
  (assert= (cons "hello\n" 0) (system-re "echo ~a" "hello")))
