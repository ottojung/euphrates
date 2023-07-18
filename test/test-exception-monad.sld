
(define-library
  (test-exception-monad)
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
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-exception-monad.scm")))
    (else (include "test-exception-monad.scm"))))
