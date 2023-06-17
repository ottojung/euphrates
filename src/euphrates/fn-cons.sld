
(define-library
  (euphrates fn-cons)
  (export fn-cons)
  (import
    (only (scheme base)
          begin
          cadr
          car
          cddr
          cdr
          cons
          define
          if
          lambda
          let
          null?))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/fn-cons.scm")))
    (else (include "fn-cons.scm"))))
