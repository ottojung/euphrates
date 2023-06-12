
(define-library
  (test-properties)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates properties) define-property)
    (only (scheme base) begin define let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-properties.scm")))
    (else (include "test-properties.scm"))))
