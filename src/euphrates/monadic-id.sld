
(define-library
  (euphrates monadic-id)
  (export monadic-id)
  (import
    (only (euphrates identity-monad) identity-monad))
  (import (only (euphrates monadic) monadic))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadic-id.scm")))
    (else (include "monadic-id.scm"))))
