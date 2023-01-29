
(cond-expand
 (guile
  (define-module (test-url-get-protocol)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates url-get-protocol) :select (url-get-protocol)))))

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
