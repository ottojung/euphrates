
(define-library
  (test-path-extensions)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates path-extensions)
          path-extensions)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-path-extensions.scm")))
    (else (include "test-path-extensions.scm"))))
