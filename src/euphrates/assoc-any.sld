
(define-library
  (euphrates assoc-any)
  (export assoc/any)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          let*
          member
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assoc-any.scm")))
    (else (include "assoc-any.scm"))))
