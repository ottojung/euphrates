
(define-library
  (euphrates catchu-case)
  (export catchu-case)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates catch-specific) catch-specific))
  (import
    (only (scheme base)
          _
          apply
          begin
          cdr
          define-syntax
          else
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/catchu-case.scm")))
    (else (include "catchu-case.scm"))))
