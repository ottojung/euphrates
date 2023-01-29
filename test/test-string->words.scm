
(cond-expand
 (guile
  (define-module (test-string->words)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates string-to-words) :select (string->words))
    :use-module ((euphrates words-to-string) :select (words->string)))))

;; string->words / words->string

(assert=
 (string->words "hello \t \t \n world!")
 (list "hello" "world!"))

(assert=
 (words->string (list "hello" "world!"))
 "hello world!")
