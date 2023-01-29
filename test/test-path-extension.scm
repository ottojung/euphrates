
%run guile

;; path-extension
%use (assert=) "./euphrates/assert-equal.scm"
%use (path-extension) "./euphrates/path-extension.scm"

(let ()
  (assert= ".txt" (path-extension "hello.txt"))
  (assert= ".tar" (path-extension "hello.txt.tar"))
  (assert= ".enc" (path-extension "hello.txt.tar.enc"))

  (assert= ".txt" (path-extension "/hi/hello.txt"))
  (assert= ".tar" (path-extension "/hi/hello.txt.tar"))
  (assert= ".enc" (path-extension "/hi/hello.txt.tar.enc"))
  (assert= ".enc" (path-extension "/h.i/hello.txt.tar.enc"))
  (assert= ".enc" (path-extension "/hi/hello.t/xt.tar.enc"))

  (assert= ".t$xt" (path-extension "hello.t$xt"))
  (assert= ".txt" (path-extension "hel$lo.txt"))
  (assert= ".tar" (path-extension "hello.t$xt.tar"))

  (assert= "" (path-extension "hello"))
  (assert= "" (path-extension ""))
  (assert= "" (path-extension "."))
  (assert= "" (path-extension ".."))
  (assert= "" (path-extension "hello.txt."))
  (assert= "" (path-extension "hello.txt.."))
  )
