
(define-library
  (test-lazy-monad)
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
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-lazy-monad.scm")))
    (else (include "test-lazy-monad.scm"))))
