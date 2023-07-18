
(define-library
  (test-system-re)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates system-re) system-re))
  (import
    (only (scheme base) begin cond-expand cons let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-system-re.scm")))
    (else (include "test-system-re.scm"))))
