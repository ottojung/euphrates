
(define-library
  (test-path-without-extension)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates path-without-extension)
          path-without-extension)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-path-without-extension.scm")))
    (else (include "test-path-without-extension.scm"))))
