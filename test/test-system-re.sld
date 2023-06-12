
(define-library
  (test-system-re)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates system-re) system-re)
    (only (scheme base) begin cons let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-system-re.scm")))
    (else (include "test-system-re.scm"))))
