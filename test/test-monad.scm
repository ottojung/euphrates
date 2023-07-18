
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates compose-under) compose-under))
   (import
     (only (euphrates identity-monad) identity-monad))
   (import
     (only (euphrates lines-to-string) lines->string))
   (import (only (euphrates log-monad) log-monad))
   (import
     (only (euphrates maybe-monad) maybe-monad))
   (import
     (only (euphrates monad-apply) monad-apply))
   (import
     (only (euphrates monad-make-no-cont)
           monad-make/no-cont))
   (import
     (only (euphrates monad-parameterize)
           with-monad-left
           with-monad-right))
   (import (only (euphrates monadic-id) monadic-id))
   (import (only (euphrates monadic) monadic))
   (import
     (only (euphrates monadstate)
           monadstate-ret
           monadstate?))
   (import (only (euphrates raisu) raisu))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           *
           +
           _
           and
           begin
           call-with-values
           cond-expand
           define
           even?
           if
           lambda
           let
           list
           not
           number?
           quote
           set!
           string-append
           values))))


;; monad basics

(define log-monad/to-string
  (lambda _
    (define buffer "")
    (define (add! monad-input)
      (let ((s (with-output-stringified
                 (monad-apply log-monad monad-input))))
        (set! buffer (string-append buffer s))))

    (monad-make/no-cont
     (lambda (monad-input)
       (add! monad-input)
       (if (monadstate? monad-input)
           monad-input
           (monadstate-ret monad-input (list buffer)))))))

(assert=
 30
 (monadic-id
  (x (+ 2 3))
  (y (* (x) (x)))
  (h (+ (x) (y)) 'tag1)))

(assert=
 '40
 (monadic-id
  (x (+ 2 3))
  ((y m) (values (* (x) (x)) (+ (x) (x))))
  (h (+ (x) (y) (m)) 'tag1)))

(call-with-values
    (lambda _
      (monadic-id
       (x (+ 2 3))
       ((y m) (values (* (x) (x)) (+ (x) (x))))
       ((h z) (values (+ (x) (y) (m)) 5) 'tag1)))
  (lambda results
    (assert= '(40 5) results)))

(assert=
 (lines->string
  (list "(x = 5 = (+ 2 3))"
        "((y m) = 25 10 = (values (* (x) (x)) (+ (x) (x))))"
        "(h = 40 = (+ (x) (y) (m)))"
        "(return 40)"
        ""))
 (with-output-stringified
   (monadic
    log-monad
    (x (+ 2 3))
    ((y m) (values (* (x) (x)) (+ (x) (x))))
    (h (+ (x) (y) (m)) 'tag1))))

(assert=
 (lines->string
  (list "(x = 5 = (+ 2 3))"
        "((y m) = 25 10 = (values (* (x) (x)) (+ (x) (x))))"
        "(h = 40 = (+ (x) (y) (m)))"
        "(return 40)"
        ""))
 (monadic
  (log-monad/to-string)
  (x (+ 2 3))
  ((y m) (values (* (x) (x)) (+ (x) (x))))
  (h (+ (x) (y) (m)) 'tag1)))

(assert=
 26
 (monadic
  (maybe-monad even?)
  (x (+ 2 3))
  (y (+ 1 (* (x) (x))))
  (h (+ (x) (y)) 'tag1)))

(assert=
 #f
 (monadic
  (maybe-monad not)
  (x (+ 2 3))
  (k #f) ;; causing to exit fast
  (z (raisu 'should-not-happen))))

(assert=
 26
 (with-monad-left
  identity-monad
  (monadic
   (maybe-monad (compose-under and number? even?))
   (x (+ 2 3))
   (y (+ 1 (* (x) (x))))
   (h (+ (x) (y)) 'tag1))))

(with-monad-left
 (log-monad/to-string)
 (assert=
  (lines->string
   (list "(x = 5 = (+ 2 3))"
         "(y = 26 = (+ 1 (* (x) (x))))"
         "(return 26)"
         ""))
  (monadic
   (maybe-monad (compose-under and number? even?))
   (x (+ 2 3))
   (y (+ 1 (* (x) (x))))
   (h (+ (x) (y)) 'tag1))))

(assert=
 (lines->string
  (list "(x = 5 = (+ 2 3))"
        "(y = 26 = (+ 1 (* (x) (x))))"
        "(return 26)"
        ""))
 (with-monad-left
  (log-monad/to-string)
  (monadic
   (maybe-monad (compose-under and number? even?))
   (x (+ 2 3))
   (y (+ 1 (* (x) (x))))
   (h (+ (x) (y)) 'tag1))))

(with-monad-left
 (log-monad/to-string)
 (assert=
  (lines->string
   (list "(x = 5 = (+ 2 3))"
         "(y = 26 = (+ 1 (* (x) (x))))"
         "(return 26)"
         ""))
  (monadic
   (maybe-monad even?)
   (x (+ 2 3))
   (y (+ 1 (* (x) (x))))
   (h (+ (x) (y)) 'tag1)))
 )

(with-monad-right
 (log-monad/to-string)
 (assert=
  (lines->string
   (list "(x = 5 = (+ 2 3))"
         "(y = 26 = (+ 1 (* (x) (x))))"
         "(return 26)"
         ""))
  (monadic
   (maybe-monad (compose-under and number? even?))
   (x (+ 2 3))
   (y (+ 1 (* (x) (x))))
   (h (+ (x) (y)) 'tag1)))
 )
