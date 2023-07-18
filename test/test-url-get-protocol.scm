
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates url-get-protocol)
           url-get-protocol))
   (import
     (only (scheme base) begin cond-expand let))))


;; url-get-protocol

(let ()
  (assert= "" (url-get-protocol "not-a-url"))
  (assert= "https" (url-get-protocol "https://gnu.org"))
  (assert= "https" (url-get-protocol "https://gnu.org/fun/humor.en.html"))
  (assert= "blob:https" (url-get-protocol "blob:https://gnu.org/fun/humor.en.html"))
  (assert= "https" (url-get-protocol "https://gnu.org/"))
  (assert= "https" (url-get-protocol "https://gnu.org//"))
  (assert= "https" (url-get-protocol "https://gnu.org://"))
  (assert= "https" (url-get-protocol "https://gnu.org://hello"))
  (assert= "https" (url-get-protocol "https://gnu.org:80//hello"))
  (assert= "http" (url-get-protocol "http://gnu.org:80//hello"))
  )
