
(cond-expand
 (guile
  (define-module (test-string-split-simple)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates string-split-simple) :select (string-split/simple))
    )))

;; string-split/simple

(let ()

  (let ()
    (assert=
     (string-split/simple "hello.txt" "e")
     '("h" "llo.txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" #\.)
     '("hello" "txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" ".")
     '("hello" "txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" "l")
     '("he" "o.txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" "ll")
     '("he" "o.txt")))

  (let ()
    (assert=
     (string-split/simple "helle.txt" "e")
     '("h" "ll" ".txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" "")
     '("hello.txt")))

  (let ()
    (assert=
     (string-split/simple "hello\n.txt" #\newline)
     '("hello" ".txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" "z")
     '("hello.txt")))

  (let ()
    (assert=
     (string-split/simple "1.1.1.." #\.)
     '("1" "1" "1")))

  )
