
(define-library
  (euphrates catchu-case)
  (export catchu-case)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates catch-specific) catch-specific))
  (import
    (only (euphrates generic-error-irritants-key)
          generic-error:irritants-key))
  (import
    (only (euphrates generic-error-value-unsafe)
          generic-error:value/unsafe))
  (import
    (only (scheme base)
          _
          apply
          begin
          define
          define-syntax
          else
          lambda
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/catchu-case.scm")))
    (else (include "catchu-case.scm"))))
