
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates url-get-path) url-get-path))
   (import
     (only (scheme base) begin cond-expand let))))


;; url-get-path

(let ()
  (assert= "/fun/humor.en.html" (url-get-path "https://gnu.org/fun/humor.en.html"))
  (assert= "/fun/humor.en.html" (url-get-path "blob:https://gnu.org/fun/humor.en.html"))
  (assert= "" (url-get-path "https://gnu.org"))
  (assert= "/" (url-get-path "https://gnu.org/"))
  (assert= "//" (url-get-path "https://gnu.org//"))
  (assert= "//" (url-get-path "https://gnu.org://"))
  (assert= "//hello" (url-get-path "https://gnu.org://hello"))
  (assert= "//hello" (url-get-path "https://gnu.org:80//hello"))
  (assert= "//hello" (url-get-path "http://gnu.org:80//hello"))
  (assert= "/fun/humor.en.html" (url-get-path "/fun/humor.en.html?arg=val1&arg2=val2"))
  (assert= "not-a-url" (url-get-path "not-a-url"))
  )
