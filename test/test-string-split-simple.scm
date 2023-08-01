
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates string-split-simple)
           string-split/simple))
   (import
     (only (scheme base) begin cond-expand let quote))))

;; string-split/simple

(let ()

  (let ()
    (assert=
     (string-split/simple "hello.txt" #\e)
     '("h" "llo.txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" #\.)
     '("hello" "txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" #\.)
     '("hello" "txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" #\l)
     '("he" "" "o.txt")))

  (let ()
    (assert=
     (string-split/simple "helle.txt" #\e)
     '("h" "ll" ".txt")))

  (let ()
    (assert=
     (string-split/simple "hello\n.txt" #\newline)
     '("hello" ".txt")))

  (let ()
    (assert=
     (string-split/simple "hello.txt" #\z)
     '("hello.txt")))

  (let ()
    (assert=
     (string-split/simple "1.1.1.." #\.)
     '("1" "1" "1" "" "")))

  (let ()
    (assert=
     (string-split/simple "" #\.)
     '()))

  (let ()
    (assert=
     (string-split/simple "..." #\.)
     '("" "" "" "")))

  )
