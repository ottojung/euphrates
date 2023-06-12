
(define-library
  (euphrates compose)
  (export compose)
  (import
    (only (scheme base)
          apply
          begin
          call-with-values
          define
          if
          lambda
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/compose.scm")))
    (else (include "compose.scm"))))
