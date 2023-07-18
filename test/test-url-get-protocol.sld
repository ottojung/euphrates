
(define-library
  (test-url-get-protocol)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates url-get-protocol)
          url-get-protocol))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-url-get-protocol.scm")))
    (else (include "test-url-get-protocol.scm"))))
