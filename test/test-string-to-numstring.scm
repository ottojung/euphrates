
(cond-expand
 (guile
  (define-module (test-string-to-numstring)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates string-to-numstring) :select (string->numstring)))))


(let () ;; string-to-numstring
  (assert= "+97-98-99-100" (string->numstring "abcd"))
  (assert= "+49-50-51-52" (string->numstring "1234"))
  (assert= "+43-52-57-45-53-48-45-53-49-45-53-50" (string->numstring (string->numstring "1234")))
  (assert= "+" (string->numstring ""))
  (assert= "+20320-22909-19990-30028" (string->numstring "你好世界"))
  )
