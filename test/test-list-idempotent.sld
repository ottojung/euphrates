
(define-library
  (test-list-idempotent)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-idempotent)
          list-idempotent))
  (import
    (only (scheme base) < begin if lambda list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-idempotent.scm")))
    (else (include "test-list-idempotent.scm"))))
