
%run guile

;; exception-monad
%use (assert) "./src/assert.scm"
%use (catch-any) "./src/catch-any.scm"
%use (exception-monad) "./src/exception-monad.scm"
%use (monadic) "./src/monadic.scm"
%use (raisu) "./src/raisu.scm"

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
