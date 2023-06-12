
(define-library
  (euphrates letin)
  (export letin)
  (import
    (only (scheme base)
          begin
          define-syntax
          let
          let-values
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/letin.scm")))
    (else (include "letin.scm"))))
