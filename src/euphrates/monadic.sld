
(define-library
  (euphrates monadic)
  (export monadic-bare monadic)
  (import
    (only (euphrates identity-star) identity*)
    (only (euphrates identity) identity)
    (only (euphrates monad-current-p)
          monad-current/p)
    (only (euphrates monad-do) monad-do/generic)
    (only (euphrates with-monad) with-monad)
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
