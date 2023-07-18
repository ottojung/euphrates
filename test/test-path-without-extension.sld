
(define-library
  (test-path-without-extension)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates path-without-extension)
          path-without-extension))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-path-without-extension.scm")))
    (else (include "test-path-without-extension.scm"))))
