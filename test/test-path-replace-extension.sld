
(define-library
  (test-path-replace-extension)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates path-replace-extension)
          path-replace-extension)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-path-replace-extension.scm")))
    (else (include "test-path-replace-extension.scm"))))
