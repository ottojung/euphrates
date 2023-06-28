
(define-library
  (test-string-to-seconds)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-to-seconds)
          string->seconds))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-to-seconds.scm")))
    (else (include "test-string-to-seconds.scm"))))
