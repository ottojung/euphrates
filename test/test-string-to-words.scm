
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
 (string->words "hello \t \t \n world!")
 (list "hello" "world!"))

(assert=
 (string->words "")
 (list))
