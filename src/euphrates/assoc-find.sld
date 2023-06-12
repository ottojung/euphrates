
(define-library
  (euphrates assoc-find)
  (export assoc/find)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          _
          begin
          car
          cdr
          define-syntax
          if
          let
          let*
          null?
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assoc-find.scm")))
    (else (include "assoc-find.scm"))))
