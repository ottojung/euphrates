
(define-library
  (euphrates define-pair)
  (export define-pair)
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          define-syntax
          define-values
          let
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/define-pair.scm")))
    (else (include "define-pair.scm"))))
