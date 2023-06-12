
(cond-expand
 (guile
  (define-module (test-path-extensions)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates path-extensions) :select (path-extensions)))))

;; path-extensions

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
  (assert= ".txt" (path-extensions "hello.txt."))
  (assert= ".txt" (path-extensions "hello.txt.."))
  (assert= ".tar.txt" (path-extensions "hello..tar..txt.."))
  )
