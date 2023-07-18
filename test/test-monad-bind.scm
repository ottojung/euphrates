
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates identity-monad) identity-monad))
   (import
     (only (euphrates lines-to-string) lines->string))
   (import (only (euphrates log-monad) log-monad))
   (import
     (only (euphrates maybe-monad) maybe-monad))
   (import (only (euphrates monad-bind) monad-bind))
   (import (only (euphrates monad-do) monad-do))
   (import (only (euphrates with-monad) with-monad))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           *
           +
           _
           begin
           call-with-values
           cond-expand
           define
           lambda
           let
           list
           newline
           quote
           values))
   (import (only (scheme write) display write))))


;; monad-bind

(let ()

  (assert=
   (lines->string
    (list
     "(#f = 8 = (+ 3 5))"
     "This is not inside of a monad"
     "(#f = 16 = (* 8 2))"
     "(return 16)"
     ""))
   (with-output-stringified
     (with-monad
      log-monad

      (monad-do (+ 3 5) 'hello)

      (display "This is not inside of a monad")
      (newline)

      (monad-do (* 8 2) 'bye)

      16
      )))

  (assert=
   (lines->string
    (list
     "(x = 8 = (+ 3 5))"
     "This is not inside of a monad"
     "The value of x is 8"
     "(y = 16 = (* 8 2))"
     "(return 16)"
     ""))
   (with-output-stringified
     (with-monad
      log-monad

      (monad-bind x (+ 3 5) 'kek)

      (define _pp
        (begin
          (display "This is not inside of a monad")
          (newline)
          (display "The value of x is ")
          (write (x))
          (newline)))

      (monad-bind y (* 8 2) 'bye)

      (y)
      )))

  (assert=
   '(10 40)
   (call-with-values
       (lambda _
         (with-monad
          (maybe-monad (lambda _ #f))

          (define x 10)
          (monad-bind y (+ x x))
          (monad-bind (r1 r2) (values x (+ (y) (y))))

          (values (r1) (r2))))
     list))

  (assert=
   10
   (with-monad
    identity-monad

    (define x 10)
    (monad-bind y (+ x x))
    (monad-bind (r1 r2) (values x (+ (y) (y))))

    x))

  )
