
%run guile

;; url-get-path
%use (assert=) "./src/assert-equal.scm"
%use (url-get-path) "./src/url-get-path.scm"

(let ()
  (assert= #f (url-get-path "not-a-url"))
  (assert= "" (url-get-path "https://gnu.org"))
  (assert= "/fun/humor.en.html" (url-get-path "https://gnu.org/fun/humor.en.html"))
  (assert= "/fun/humor.en.html" (url-get-path "blob:https://gnu.org/fun/humor.en.html"))
  (assert= "/" (url-get-path "https://gnu.org/"))
  (assert= "//" (url-get-path "https://gnu.org//"))
  (assert= "//" (url-get-path "https://gnu.org://"))
  (assert= "//hello" (url-get-path "https://gnu.org://hello"))
  (assert= "//hello" (url-get-path "https://gnu.org:80//hello"))
  (assert= "//hello" (url-get-path "http://gnu.org:80//hello"))
  )
