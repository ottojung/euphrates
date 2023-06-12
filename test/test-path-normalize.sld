
(define-library
  (test-path-normalize)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates path-normalize) path-normalize)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-path-normalize.scm")))
    (else (include "test-path-normalize.scm"))))
