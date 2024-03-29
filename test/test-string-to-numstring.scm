
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates string-to-numstring)
           string->numstring))
   (import
     (only (scheme base) begin cond-expand let))))



(let () ;; string-to-numstring
  (assert= "+97-98-99-100" (string->numstring "abcd"))
  (assert= "+49-50-51-52" (string->numstring "1234"))
  (assert= "+43-52-57-45-53-48-45-53-49-45-53-50" (string->numstring (string->numstring "1234")))
  (assert= "+" (string->numstring ""))
  (assert= "+20320-22909-19990-30028" (string->numstring "你好世界"))
  )
