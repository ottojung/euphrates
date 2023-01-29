
%run guile

;; url-get-hostname-and-port
%use (assert=) "./euphrates/assert-equal.scm"
%use (url-get-hostname-and-port) "./euphrates/url-get-hostname-and-port.scm"

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
