
(define-library
  (test-assq-unset-multiple-values)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assq-unset-multiple-values)
          assq-unset-multiple-values))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-assq-unset-multiple-values.scm")))
    (else (include "test-assq-unset-multiple-values.scm"))))
