
%run guile

;; monad-bind
%use (assert=) "./src/assert-equal.scm"
%use (identity-monad) "./src/identity-monad.scm"
%use (lines->string) "./src/lines-to-string.scm"
%use (log-monad) "./src/log-monad.scm"
%use (maybe-monad) "./src/maybe-monad.scm"
%use (monad-bind) "./src/monad-bind.scm"
%use (monad-do) "./src/monad-do.scm"
%use (with-monad) "./src/with-monad.scm"

(let ()

  (assert=
   (lines->string
    (list
     "(#f = 8 = (+ 3 5))"
     "This is not inside of a monad"
     "(#f = 16 = (* 8 2))"
     "(return 16)"
     ""))
   (with-output-to-string
     (lambda _

       (with-monad
        log-monad

        (monad-do (+ 3 5) 'hello)

        (display "This is not inside of a monad")
        (newline)

        (monad-do (* 8 2) 'bye)

        16
        ))))

  (assert=
   (lines->string
    (list
     "(x = 8 = (+ 3 5))"
     "This is not inside of a monad"
     "The value of x is 8"
     "(y = 16 = (* 8 2))"
     "(return 16)"
     ""))
   (with-output-to-string
     (lambda _

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
        ))))

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
