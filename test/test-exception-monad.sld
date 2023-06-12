
(define-library
  (test-exception-monad)
  (import
    (only (euphrates assert) assert)
    (only (euphrates catch-any) catch-any)
    (only (euphrates exception-monad)
          exception-monad)
    (only (euphrates monadic) monadic)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          +
          -
          _
          begin
          lambda
          let
          quote
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-exception-monad.scm")))
    (else (include "test-exception-monad.scm"))))
