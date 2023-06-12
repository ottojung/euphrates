
(define-library
  (euphrates fn-pair)
  (export fn-pair)
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          define-syntax
          lambda
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/fn-pair.scm")))
    (else (include "fn-pair.scm"))))
