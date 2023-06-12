
(define-library
  (test-string-take-n)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates string-take-n) string-take-n)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-take-n.scm")))
    (else (include "test-string-take-n.scm"))))
