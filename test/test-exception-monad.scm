
(cond-expand
 (guile
  (define-module (test-exception-monad)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates catch-any) :select (catch-any))
    :use-module ((euphrates exception-monad) :select (exception-monad))
    :use-module ((euphrates monadic) :select (monadic))
    :use-module ((euphrates raisu) :select (raisu)))))

;; exception-monad

(let ((ran-always #f)
      (throwed #t)
      (did-not-ran #t)
      (exception-throwed #f))

  (catch-any
   (lambda _
     (monadic (exception-monad)
              [a (+ 2 7)]
              [o (+ (a) (a))]
              [b (raisu 'test-abort)]
              [p "after kek" 'always]
              [q "this should not get a value"]
              [r (set! ran-always #t) 'always]
              [k (set! did-not-ran #f)]
              [c (- (b) (b))]
              [r (+ 100 (c))]
              )
     (set! throwed #f))
   (lambda errs
     (set! exception-throwed #t)))

  (assert exception-throwed)
  (assert ran-always)
  (assert did-not-ran)
  (assert throwed))
