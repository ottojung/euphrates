
(cond-expand
 (guile
  (define-module (test-md5)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates md5) :select (md5-digest))
    )))

(assert=
 (md5-digest "hello")
 "5d41402abc4b2a76b9719d911017c592")

(assert=
 (md5-digest "a b c\nd e\tf")
 "572853b8bb902e996262c34b39a850d0")

(assert=
 (md5-digest "")
 "d41d8cd98f00b204e9800998ecf8427e")
