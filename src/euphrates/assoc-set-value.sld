
(define-library
  (euphrates assoc-set-value)
  (export assoc-set-value)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          equal?
          if
          let
          null?
          quasiquote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assoc-set-value.scm")))
    (else (include "assoc-set-value.scm"))))
