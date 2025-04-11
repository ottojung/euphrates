
(define-library
  (euphrates define-union-type)
  (export define-union-type)
  (import
    (only (scheme base)
          _
          begin
          case
          cond
          define-syntax
          lambda
          syntax-error
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/define-union-type.scm")))
    (else (include "define-union-type.scm"))))
