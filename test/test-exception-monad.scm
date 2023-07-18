
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import (only (euphrates catch-any) catch-any))
   (import
     (only (euphrates exception-monad)
           exception-monad))
   (import (only (euphrates monadic) monadic))
   (import (only (euphrates raisu) raisu))
   (import
     (only (scheme base)
           +
           -
           _
           begin
           cond-expand
           lambda
           let
           quote
           set!))))


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
