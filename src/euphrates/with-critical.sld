
(define-library
  (euphrates with-critical)
  (export with-critical)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/with-critical.scm")))
    (else (include "with-critical.scm"))))
