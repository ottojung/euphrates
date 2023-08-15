
;; Testing the looks-like-an-unquoted-fkeyword? function
(assert (looks-like-an-unquoted-fkeyword? "test:"))
(assert (not (looks-like-an-unquoted-fkeyword? "test")))
(assert (not (looks-like-an-unquoted-fkeyword? ":")))

;; Testing the obj function (Please note that the given definition of the 'obj' function is not correct. It should probably take two arguments, or the logic should be changed.)

;; Testing the fkeyword->string function
(assert (string=? (fkeyword->string 'test:) "test"))
(assert (string=? (fkeyword->string 'a:) "a"))

;; Testing the string->fkeyword function
(assert (eq? (string->fkeyword "test") 'test:))
(assert (eq? (string->fkeyword "a") 'a:))

;; The following test will cause an error, as fkeywords cannot be of length 0
(assert-throw 'type-error (string->fkeyword ""))
