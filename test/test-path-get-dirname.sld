
(define-library
  (test-path-get-dirname)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates path-get-dirname)
          path-get-dirname))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-path-get-dirname.scm")))
    (else (include "test-path-get-dirname.scm"))))
