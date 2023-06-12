
(define-library
  (euphrates list-ref-or)
  (export list-ref-or)
  (import
    (only (scheme base)
          -
          =
          _
          begin
          car
          cdr
          define-syntax
          if
          let
          null?
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-ref-or.scm")))
    (else (include "list-ref-or.scm"))))
