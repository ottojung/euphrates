
(define-library
  (test-path-extension)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates path-extension) path-extension)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-path-extension.scm")))
    (else (include "test-path-extension.scm"))))
