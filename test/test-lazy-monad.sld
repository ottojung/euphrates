
(define-library
  (test-lazy-monad)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates lazy-monad) lazy-monad)
    (only (euphrates monadic) monadic)
    (only (euphrates np-thread-parameterize)
          with-np-thread-env/non-interruptible)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          *
          +
          _
          begin
          lambda
          let*
          quote
          values)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-lazy-monad.scm")))
    (else (include "test-lazy-monad.scm"))))
