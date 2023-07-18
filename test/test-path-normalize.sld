
(define-library
  (test-path-normalize)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates path-normalize) path-normalize))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-path-normalize.scm")))
    (else (include "test-path-normalize.scm"))))
