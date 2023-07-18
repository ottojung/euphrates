
(define-library
  (test-string-take-n)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-take-n) string-take-n))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-take-n.scm")))
    (else (include "test-string-take-n.scm"))))
