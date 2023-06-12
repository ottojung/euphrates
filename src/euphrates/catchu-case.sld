
(define-library
  (euphrates catchu-case)
  (export catchu-case)
  (import
    (only (scheme base)
          _
          apply
          begin
          cdr
          cond-expand
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) catch))
           (begin
             (include-from-path "euphrates/catchu-case.scm")))
    (else (include "catchu-case.scm"))))
