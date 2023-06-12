
(define-library
  (euphrates assoc-set-default)
  (export assoc-set-default)
  (import
    (only (euphrates assoc-set-value)
          assoc-set-value)
    (only (scheme base)
          _
          assoc
          begin
          define
          define-syntax
          if
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assoc-set-default.scm")))
    (else (include "assoc-set-default.scm"))))
