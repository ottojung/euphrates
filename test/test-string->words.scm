
%run guile

;; string->words / words->string
%use (assert=) "./euphrates/assert-equal.scm"
%use (string->words) "./euphrates/string-to-words.scm"
%use (words->string) "./euphrates/words-to-string.scm"

(assert=
 (string->words "hello \t \t \n world!")
 (list "hello" "world!"))

(assert=
 (words->string (list "hello" "world!"))
 "hello world!")
