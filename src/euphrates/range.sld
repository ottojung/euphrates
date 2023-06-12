
(define-library
  (euphrates range)
  (export range)
  (import
    (only (scheme base)
          +
          -
          >
          begin
          cons
          define
          if
          quote)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-1) count))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/range.scm")))
    (else (include "range.scm"))))
