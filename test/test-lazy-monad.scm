
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import (only (euphrates lazy-monad) lazy-monad))
   (import (only (euphrates monadic) monadic))
   (import
     (only (euphrates np-thread-parameterize)
           with-np-thread-env/non-interruptible))
   (import
     (only (euphrates with-output-stringified)
           with-output-stringified))
   (import
     (only (scheme base)
           *
           +
           begin
           cond-expand
           let*
           quote
           values))
   (import (only (scheme write) display))))


;; lazy-monad

(with-np-thread-env/non-interruptible
 (assert=
  31
  (monadic
   lazy-monad
   (x (+ 2 3))
   (y (+ 1 (* (x) (x))))
   (h (+ (x) (y)) 'tag1)))

 (assert=
  31
  (monadic
   lazy-monad
   (x (+ 2 3) 'async)
   (y (+ 1 (* (x) (x))) 'async)
   (h (+ (x) (y)) 'tag1)))

 (assert=
  "5.4.1.3.2."
  (with-output-stringified
    (monadic
     lazy-monad
     (x (begin (display "1.") (+ 2 3)))
     (y (begin (display "2.") (* 4 5)))
     ((p t) (begin
              (display "3.")
              (values (+ (y) (y)) (* (y) (y)))))
     (z (begin (display "4.") (+ (x) (x))))
     (r (begin (display "5.") (let* ((zz (z)) (pp (p))) (+ zz pp))))
     )))

 )
