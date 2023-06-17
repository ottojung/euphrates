
(define-library
  (euphrates partial-apply)
  (export partial-apply)
  (import
    (only (euphrates reversed-args-f)
          reversed-args-f))
  (import
    (only (scheme base)
          _
          apply
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (srfi srfi-1) cons* last)))
    (else (import (only (srfi 1) cons* last))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/partial-apply.scm")))
    (else (include "partial-apply.scm"))))
