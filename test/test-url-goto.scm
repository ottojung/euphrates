
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates url-goto) url-goto))
   (import
     (only (scheme base) begin cond-expand let))))


;; url-goto

(let ()
  (assert= "https://gnu.org/philosophy/philosophy.html"
           (url-goto "https://gnu.org/fun/humor.en.html"
                     "/philosophy/philosophy.html"))

  (assert= "https://gnu.org/fun/jokes/bug.war.html"
           (url-goto "https://gnu.org/fun/humor.en.html"
                     "jokes/bug.war.html"))

  (assert= "https://gnu.org/fun/jokes/bug.war.html"
           (url-goto "https://gnu.org/fun/"
                     "jokes/bug.war.html"))

  (assert= "https://gnu.org/fun/jokes/bug.war.html"
           (url-goto "https://gnu.org/fun/?a=1&b=2"
                     "jokes/bug.war.html"))

  (assert= "https://jokes/bug.war.html"
           (url-goto "https://gnu.org/fun/?a=1&b=2"
                     "//jokes/bug.war.html"))

  (assert= "https://wikipedia.org/philosophy.html"
           (url-goto "https://gnu.org/fun/humor.en.html"
                     "https://wikipedia.org/philosophy.html"))

  )
