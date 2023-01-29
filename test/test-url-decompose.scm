
%run guile

;; url-decompose
%use (assert=) "./euphrates/assert-equal.scm"
%use (url-decompose) "./euphrates/url-decompose.scm"

(let ()
  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "a=1&b=2" "some-fragment")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here?a=1&b=2#some-fragment"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f "some-fragment?a=1&b=2")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here#some-fragment?a=1&b=2"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "a=1&b=2" #f)
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here?a=1&b=2"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "a=1&b=2" "")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here?a=1&b=2#"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "" "some-fragment")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here?#some-fragment"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f "some-fragment")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here#some-fragment"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f "")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here#"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" "" "")
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here?#"))

  (assert=
   #("http" "gnu.org:80" "/fun/humor.en.html;some-params-here" #f #f)
   (url-decompose "http://gnu.org:80/fun/humor.en.html;some-params-here"))

  (assert=
   #("http" "gnu.org:80" "/" "a=1&b=c" #f)
   (url-decompose "http://gnu.org:80/?a=1&b=c"))

  (assert=
   #("http" "gnu.org:80?a=1&b=c" "" #f #f)
   (url-decompose "http://gnu.org:80?a=1&b=c"))

  (assert=
   #("http" "gnu.org:80" "/" #f #f)
   (url-decompose "http://gnu.org:80/"))
  )
