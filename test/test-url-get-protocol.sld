
(define-library
  (test-url-get-protocol)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates url-get-protocol)
          url-get-protocol)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-url-get-protocol.scm")))
    (else (include "test-url-get-protocol.scm"))))
