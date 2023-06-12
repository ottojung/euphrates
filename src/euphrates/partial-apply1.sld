
(define-library
  (euphrates partial-apply1)
  (export partial-apply1)
  (import
    (only (euphrates reversed-args-f)
          reversed-args-f)
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules)
    (only (srfi srfi-1) last))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/partial-apply1.scm")))
    (else (include "partial-apply1.scm"))))
