
(define-library
  (euphrates lazy-parameter)
  (export lazy-parameter)
  (import (only (euphrates memconst) memconst))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          let
          make-parameter
          parameterize
          syntax-rules))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lazy-parameter.scm")))
    (else (include "lazy-parameter.scm"))))
