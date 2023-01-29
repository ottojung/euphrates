
%run guile

;; monad basics
%use (assert=) "./euphrates/assert-equal.scm"
%use (compose-under) "./euphrates/compose-under.scm"
%use (identity-monad) "./euphrates/identity-monad.scm"
%use (lines->string) "./euphrates/lines-to-string.scm"
%use (log-monad) "./euphrates/log-monad.scm"
%use (maybe-monad) "./euphrates/maybe-monad.scm"
%use (monad-apply) "./euphrates/monad-apply.scm"
%use (monad-make/no-cont) "./euphrates/monad-make-no-cont.scm"
%use (with-monad-left with-monad-right) "./euphrates/monad-parameterize.scm"
%use (monadic-id) "./euphrates/monadic-id.scm"
%use (monadic) "./euphrates/monadic.scm"
%use (monadstate-ret monadstate?) "./euphrates/monadstate.scm"
%use (raisu) "./euphrates/raisu.scm"

(define log-monad/to-string
  (lambda _
    (define buffer "")
    (define (add! monad-input)
      (let ((s (with-output-to-string
                 (lambda _ (monad-apply log-monad monad-input)))))
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
 (with-output-to-string
   (lambda _
     (monadic
      log-monad
      (x (+ 2 3))
      ((y m) (values (* (x) (x)) (+ (x) (x))))
      (h (+ (x) (y) (m)) 'tag1)))))

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
