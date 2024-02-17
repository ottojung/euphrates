
(define-library
  (test-list-idempotent)
  (import (only (euphrates debug) debug))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-idempotent.scm")))
    (else (include "test-list-idempotent.scm"))))
