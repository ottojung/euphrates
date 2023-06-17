
(define-library
  (euphrates monadic)
  (export monadic-bare monadic)
  (import
    (only (euphrates identity-star) identity*))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates monad-current-p)
          monad-current/p))
  (import
    (only (euphrates monad-do) monad-do/generic))
  (import (only (euphrates with-monad) with-monad))
  (import
    (only (scheme base)
          _
          apply
          begin
          call-with-values
          define-syntax
          lambda
          let
          list
          map
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monadic.scm")))
    (else (include "monadic.scm"))))
