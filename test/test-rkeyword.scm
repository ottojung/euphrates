
;; Testing the looks-like-an-unquoted-rkeyword? function
(assert (looks-like-an-unquoted-rkeyword? ":test"))
(assert (not (looks-like-an-unquoted-rkeyword? "test")))
(assert (not (looks-like-an-unquoted-rkeyword? ":")))

;; Testing the obj function (Please note that the given definition of the 'obj' function is not correct. It should probably take two arguments, or the logic should be changed.)

;; Testing the rkeyword->string function
(assert (string=? (rkeyword->string ':test) "test"))
(assert (string=? (rkeyword->string ':a) "a"))

;; Testing the string->rkeyword function
(assert (eq? (string->rkeyword "test") ':test))
(assert (eq? (string->rkeyword "a") ':a))

;; The following test will cause an error, as rkeywords cannot be of length 0
(assert-throw 'type-error (string->rkeyword ""))
