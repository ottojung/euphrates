
(define-library
  (euphrates list-traverse)
  (export list-traverse)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          define-values
          if
          let
          let*
          null?))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-traverse.scm")))
    (else (include "list-traverse.scm"))))
