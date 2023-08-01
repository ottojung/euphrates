
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates string-to-words) string->words))
   (import
     (only (euphrates words-to-string) words->string))
   (import
     (only (scheme base) begin cond-expand list))))


(assert=
 (words->string (list "hello" "world!"))
 "hello world!")

(assert=
 (words->string (list "hello"))
 "hello")

(assert=
 (words->string (list)) "")

(assert=
 (words->string (list "")) "")
