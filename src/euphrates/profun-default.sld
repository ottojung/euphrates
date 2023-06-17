
(define-library
  (euphrates profun-default)
  (export profun-default)
  (import
    (only (euphrates profun-value)
          profun-unbound-value?))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          if
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-default.scm")))
    (else (include "profun-default.scm"))))
