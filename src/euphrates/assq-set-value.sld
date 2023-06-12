
(define-library
  (euphrates assq-set-value)
  (export assq-set-value)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          eq?
          if
          let
          null?
          quasiquote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assq-set-value.scm")))
    (else (include "assq-set-value.scm"))))
