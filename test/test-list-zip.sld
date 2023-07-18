
(define-library
  (test-list-zip)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates list-zip) list-zip))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-zip.scm")))
    (else (include "test-list-zip.scm"))))
