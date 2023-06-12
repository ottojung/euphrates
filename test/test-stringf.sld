
(define-library
  (test-stringf)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates stringf) stringf)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-stringf.scm")))
    (else (include "test-stringf.scm"))))
