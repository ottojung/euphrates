
(cond-expand
 (guile
  (define-module (test-url-decompose)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates url-decompose) :select (url-decompose)))))

;; url-decompose

(define (testv url correct-vector)
  (define-values (protocol netloc path query fragment)
    (url-decompose url))

  (assert=
   correct-vector
   (vector protocol netloc path query fragment)))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here?a=1&b=2#some-fragment"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "a=1&b=2" "some-fragment"))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here#some-fragment?a=1&b=2"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f "some-fragment?a=1&b=2"))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here?a=1&b=2"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "a=1&b=2" #f))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here?a=1&b=2#"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "a=1&b=2" ""))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here?#some-fragment"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "" "some-fragment"))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here#some-fragment"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f "some-fragment"))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here#"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f ""))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here?#"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "" ""))

(testv
 "http://gnu.org:80/fun/humor.en.html;some-params-here"
 #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f #f))

(testv
 "http://gnu.org:80/?a=1&b=c"
 #("http" "gnu.org:80" "/" "a=1&b=c" #f))

(testv
 "http://gnu.org:80?a=1&b=c"
 #("http" "gnu.org:80?a=1&b=c" "" #f #f))

(testv
 "http://gnu.org:80/"
 #("http" "gnu.org:80" "/" #f #f))
