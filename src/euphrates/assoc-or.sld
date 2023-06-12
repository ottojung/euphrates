
(define-library
  (euphrates assoc-or)
  (export assoc-or)
  (import
    (only (scheme base)
          _
          and
          assoc
          begin
          cdr
          define-syntax
          if
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assoc-or.scm")))
    (else (include "assoc-or.scm"))))
