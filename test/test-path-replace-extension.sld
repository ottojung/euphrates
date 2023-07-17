
(define-library
  (test-path-replace-extension)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-path-replace-extension.scm")))
    (else (include "test-path-replace-extension.scm"))))
