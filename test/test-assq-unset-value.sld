
(define-library
  (test-assq-unset-value)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assq-unset-value)
          assq-unset-value))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-assq-unset-value.scm")))
    (else (include "test-assq-unset-value.scm"))))
