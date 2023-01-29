
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (string-take-n) "./euphrates/string-take-n.scm"

(let () ;; string-take-n
  (assert= "" (string-take-n 0 "hello"))
  (assert= "h" (string-take-n 1 "hello"))
  (assert= "he" (string-take-n 2 "hello"))
  (assert= "hel" (string-take-n 3 "hello"))
  (assert= "hell" (string-take-n 4 "hello"))
  (assert= "hello" (string-take-n 5 "hello"))
  (assert= "hello" (string-take-n 6 "hello"))
  (assert= "hello" (string-take-n 612381238 "hello"))
  (assert= "" (string-take-n -1 "hello"))
  (assert= "" (string-take-n 0 ""))
  (assert= "" (string-take-n 5 "")))
