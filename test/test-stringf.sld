
(define-library
  (test-stringf)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-stringf.scm")))
    (else (include "test-stringf.scm"))))
