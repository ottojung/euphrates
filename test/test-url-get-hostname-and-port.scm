
(cond-expand
 (guile
  (define-module (test-url-get-hostname-and-port)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates url-get-hostname-and-port) :select (url-get-hostname-and-port)))))

;; url-get-hostname-and-port

(let ()
  (assert= "" (url-get-hostname-and-port "not-a-url"))
  (assert= "gnu.org" (url-get-hostname-and-port "https://gnu.org"))
  (assert= "gnu.org" (url-get-hostname-and-port "https://gnu.org/fun/humor.en.html"))
  (assert= "gnu.org" (url-get-hostname-and-port "blob:https://gnu.org/fun/humor.en.html"))
  (assert= "gnu.org" (url-get-hostname-and-port "https://gnu.org/"))
  (assert= "gnu.org" (url-get-hostname-and-port "https://gnu.org//"))
  (assert= "gnu.org:" (url-get-hostname-and-port "https://gnu.org://"))
  (assert= "gnu.org:" (url-get-hostname-and-port "https://gnu.org://hello"))
  (assert= "gnu.org:80" (url-get-hostname-and-port "https://gnu.org:80//hello"))
  )
