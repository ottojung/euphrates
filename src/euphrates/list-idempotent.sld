(define-library
  (euphrates list-idempotent)
  (export list-idempotent)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-idempotent.scm")))
    (else (include "list-idempotent.scm"))))
