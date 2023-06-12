
(define-library
  (euphrates list-fold)
  (export list-fold)
  (import
    (only (scheme base)
          _
          apply
          begin
          call-with-values
          car
          cdr
          define-syntax
          if
          lambda
          let
          null?
          syntax-rules
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-fold.scm")))
    (else (include "list-fold.scm"))))
