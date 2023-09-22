
(define-library
  (euphrates assq-unset-multiple-values)
  (export assq-unset-multiple-values)
  (import
    (only (euphrates assq-unset-value)
          assq-unset-value))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assq-unset-multiple-values.scm")))
    (else (include "assq-unset-multiple-values.scm"))))
