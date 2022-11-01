
%run guile

;; path-without-extension
%use (assert=) "./src/assert-equal.scm"
%use (path-without-extension) "./src/path-without-extension.scm"

(let ()
  (assert= "hello" (path-without-extension "hello.txt"))
  (assert= "hello.txt" (path-without-extension "hello.txt.tar"))
  (assert= "hello.txt.tar" (path-without-extension "hello.txt.tar.enc"))

  (assert= "/hi/hello" (path-without-extension "/hi/hello.txt"))
  (assert= "/hi/hello.txt" (path-without-extension "/hi/hello.txt.tar"))
  (assert= "/hi/hello.txt.tar" (path-without-extension "/hi/hello.txt.tar.enc"))

  (assert= "hello" (path-without-extension "hello"))
  (assert= "" (path-without-extension ""))
  (assert= "" (path-without-extension "."))
  )
