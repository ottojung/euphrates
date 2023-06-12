

;; string->words / words->string

(assert=
 (string->words "hello \t \t \n world!")
 (list "hello" "world!"))

(assert=
 (words->string (list "hello" "world!"))
 "hello world!")
