
(define-library
  (test-url-get-path)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates url-get-path) url-get-path)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-url-get-path.scm")))
    (else (include "test-url-get-path.scm"))))
