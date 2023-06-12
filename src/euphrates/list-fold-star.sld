
(define-library
  (euphrates list-fold-star)
  (export list-fold*)
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          define-syntax
          define-values
          if
          let
          null?
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-fold-star.scm")))
    (else (include "list-fold-star.scm"))))
