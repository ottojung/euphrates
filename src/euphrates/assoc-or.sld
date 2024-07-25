
(define-library
  (euphrates assoc-or)
  (export assoc-or)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          _
          assoc
          begin
          cdr
          define-syntax
          if
          let
          list
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assoc-or.scm")))
    (else (include "assoc-or.scm"))))
