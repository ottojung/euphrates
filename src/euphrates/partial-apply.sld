
(define-library
  (euphrates partial-apply)
  (export partial-apply)
  (import
    (only (euphrates reversed-args-f)
          reversed-args-f)
    (only (scheme base)
          _
          apply
          begin
          define-syntax
          lambda
          syntax-rules)
    (only (srfi srfi-1) cons* last))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/partial-apply.scm")))
    (else (include "partial-apply.scm"))))
