
%run guile

;; string-split-3
%use (assert=) "./src/assert-equal.scm"
%use (string-split-3) "./src/string-split-3.scm"

(let ()

  (let ()
    (define-values (pre it post)
      (string-split-3 "." "hello.txt"))
    (assert= pre "hello")
    (assert= it ".")
    (assert= post "txt"))

  (let ()
    (define-values (pre it post)
      (string-split-3 #\. "hello.txt"))
    (assert= pre "hello")
    (assert= it ".")
    (assert= post "txt"))

  (let ()
    (define-values (pre it post)
      (string-split-3 "o." "hello.txt"))
    (assert= pre "hell")
    (assert= it "o.")
    (assert= post "txt"))

  (let ()
    (define-values (pre it post)
      (string-split-3 "txt" "hello.txt"))
    (assert= pre "hello.")
    (assert= it "txt")
    (assert= post ""))

  (let ()
    (define-values (pre it post)
      (string-split-3 "txk" "hello.txt"))
    (assert= pre "hello.txt")
    (assert= it "")
    (assert= post ""))

  (let ()
    (define-values (pre it post)
      (string-split-3 "txtk" "hello.txt"))
    (assert= pre "hello.txt")
    (assert= it "")
    (assert= post ""))

  (let ()
    (define-values (pre it post)
      (string-split-3 #\f "hello.txt"))
    (assert= pre "hello.txt")
    (assert= it "")
    (assert= post ""))

  (let ()
    (define-values (pre it post)
      (string-split-3 (lambda (c) (member c (string->list ".abcdef"))) "hello.txt"))
    (assert= pre "h")
    (assert= it "e")
    (assert= post "llo.txt"))

  (let ()
    (define-values (pre it post)
      (string-split-3 (const #f) "hello.txt"))
    (assert= pre "hello.txt")
    (assert= it "")
    (assert= post ""))

  )
