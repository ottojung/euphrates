
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates url-get-hostname-and-port)
           url-get-hostname-and-port))
   (import
     (only (scheme base) begin cond-expand let))))


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
