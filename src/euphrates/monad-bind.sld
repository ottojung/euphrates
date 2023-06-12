
(define-library
  (euphrates monad-bind)
  (export monad-bind)
  (import
    (only (euphrates monad-do) monad-do/generic)
    (only (scheme base)
          _
          begin
          define
          define-syntax
          define-values
          list
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/monad-bind.scm")))
    (else (include "monad-bind.scm"))))
