
(cond-expand
 (guile
  (define-module (test-url-goto)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates url-goto) :select (url-goto)))))

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
