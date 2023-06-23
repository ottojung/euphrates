
(define-library
  (euphrates caseq)
  (export caseq)
  (import
    (only (euphrates syntax-reverse) syntax-reverse))
  (import
    (only (scheme base)
          _
          begin
          case
          define-syntax
          else
          quote
          syntax-error
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path catch))
           (begin (include-from-path "euphrates/caseq.scm")))
    (else (include "caseq.scm"))))
