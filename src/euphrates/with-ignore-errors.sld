
(define-library
  (euphrates with-ignore-errors)
  (export with-ignore-errors!)
  (import (only (euphrates catch-any) catch-any))
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
             (include-from-path
               "euphrates/with-ignore-errors.scm")))
    (else (include "with-ignore-errors.scm"))))
