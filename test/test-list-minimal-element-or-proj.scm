
(assert=
 "a"
 (list-minimal-element-or/proj
  #f identity string<=?
  (list "a" "aa" "aaa" "aaaa" "aa" "a")))

(assert=
 "a"
 (list-minimal-element-or/proj
  #f string-length <
  (list "a" "aa" "aaa" "aaaa" "aa" "a")))
