
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates const) const))
   (import
     (only (euphrates string-split-3) string-split-3))
   (import
     (only (scheme base)
           begin
           cond-expand
           define-values
           lambda
           let
           member
           string->list))))


;; string-split-3

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
