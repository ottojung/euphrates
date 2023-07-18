
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates identity) identity))
   (import
     (only (euphrates list-minimal-element-or-proj)
           list-minimal-element-or/proj))
   (import
     (only (scheme base)
           <
           begin
           cond-expand
           list
           string-length
           string<=?))))

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
