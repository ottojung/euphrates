
%run guile

;; url-get-protocol
%use (assert=) "./src/assert-equal.scm"
%use (url-get-protocol) "./src/url-get-protocol.scm"

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
