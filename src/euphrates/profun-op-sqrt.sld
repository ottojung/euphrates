
(define-library
  (euphrates profun-op-sqrt)
  (export profun-op-sqrt)
  (import
    (only (euphrates profun-op-unary)
          profun-op-unary)
    (only (scheme base) * begin define lambda)
    (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-sqrt.scm")))
    (else (include "profun-op-sqrt.scm"))))
