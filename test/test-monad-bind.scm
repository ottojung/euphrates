
(cond-expand
 (guile
  (define-module (test-monad-bind)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates identity-monad) :select (identity-monad))
    :use-module ((euphrates lines-to-string) :select (lines->string))
    :use-module ((euphrates log-monad) :select (log-monad))
    :use-module ((euphrates maybe-monad) :select (maybe-monad))
    :use-module ((euphrates monad-bind) :select (monad-bind))
    :use-module ((euphrates monad-do) :select (monad-do))
    :use-module ((euphrates with-monad) :select (with-monad)))))

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
