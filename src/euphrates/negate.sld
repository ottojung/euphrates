
(define-library
  (euphrates negate)
  (export negate)
  (import
    (only (scheme base)
          apply
          begin
          define
          lambda
          not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/negate.scm")))
    (else (include "negate.scm"))))
