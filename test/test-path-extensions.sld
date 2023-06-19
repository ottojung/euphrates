
(define-library
  (test-path-extensions)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates path-extensions)
          path-extensions))
  (import (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-path-extensions.scm")))
    (else (include "test-path-extensions.scm"))))
