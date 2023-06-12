
(define-library
  (test-url-get-hostname-and-port)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates url-get-hostname-and-port)
          url-get-hostname-and-port)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-url-get-hostname-and-port.scm")))
    (else (include "test-url-get-hostname-and-port.scm"))))
