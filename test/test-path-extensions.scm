
%run guile

;; path-extensions
%use (assert=) "./euphrates/assert-equal.scm"
%use (path-extensions) "./euphrates/path-extensions.scm"

(let ()
  (assert= ".txt" (path-extensions "hello.txt"))
  (assert= ".txt.tar" (path-extensions "hello.txt.tar"))
  (assert= ".txt.tar.enc" (path-extensions "hello.txt.tar.enc"))

  (assert= ".txt" (path-extensions "/hi/hello.txt"))
  (assert= ".txt.tar" (path-extensions "/hi/hello.txt.tar"))
  (assert= ".txt.tar.enc" (path-extensions "/hi/hello.txt.tar.enc"))
  (assert= ".txt.tar.enc" (path-extensions "/h.i/hello.txt.tar.enc"))
  (assert= ".tar.enc" (path-extensions "/hi/hello.t/xt.tar.enc"))

  (assert= "" (path-extensions "hello.t$xt"))
  (assert= ".txt" (path-extensions "hel$lo.txt"))
  (assert= ".tar" (path-extensions "hello.t$xt.tar"))

  (assert= "" (path-extensions "hello"))
  (assert= "" (path-extensions ""))
  (assert= "" (path-extensions "."))
  (assert= "" (path-extensions ".."))
  (assert= "" (path-extensions "hello.txt."))
  (assert= "" (path-extensions "hello.txt.."))
  )
