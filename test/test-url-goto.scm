
%run guile

;; url-goto
%use (assert=) "./src/assert-equal.scm"
%use (url-goto) "./src/url-goto.scm"

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

  )
