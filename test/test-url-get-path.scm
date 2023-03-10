
(cond-expand
 (guile
  (define-module (test-url-get-path)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates url-get-path) :select (url-get-path)))))

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
