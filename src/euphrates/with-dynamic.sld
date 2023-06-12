
(define-library
  (euphrates with-dynamic)
  (export with-dynamic)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          if
          lambda
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) parameter?))
           (begin
             (include-from-path "euphrates/with-dynamic.scm")))
    (else (include "with-dynamic.scm"))))
