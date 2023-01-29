
%run guile

;; system-re
%use (assert=) "./euphrates/assert-equal.scm"
%use (system-re) "./euphrates/system-re.scm"

(let ()
  (assert= (cons "hello\n" 0) (system-re "echo hello"))
  (assert= (cons "hello\n" 0) (system-re "echo ~a" "hello")))
