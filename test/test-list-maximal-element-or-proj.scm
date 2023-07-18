
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates identity) identity))
   (import
     (only (euphrates list-maximal-element-or-proj)
           list-maximal-element-or/proj))
   (import
     (only (scheme base)
           >
           begin
           cond-expand
           list
           string-length
           string>=?))))

(assert=
 "aaaa"
 (list-maximal-element-or/proj
  #f identity string>=?
  (list "a" "aa" "aaa" "aaaa" "aa" "a")))

(assert=
 "aaaa"
 (list-maximal-element-or/proj
  #f string-length >
  (list "a" "aa" "aaa" "aaaa" "aa" "a")))
