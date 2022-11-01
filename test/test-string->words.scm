
%run guile

;; string->words / words->string
%use (assert=) "./src/assert-equal.scm"
%use (string->words) "./src/string-to-words.scm"
%use (words->string) "./src/words-to-string.scm"

(assert=
 (string->words "hello \t \t \n world!")
 (list "hello" "world!"))

(assert=
 (words->string (list "hello" "world!"))
 "hello world!")
