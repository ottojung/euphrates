
(define-library
  (test-string-plus-encode)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates string-plus-encode)
          string-plus-encode)
    (only (scheme base) begin define let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-plus-encode.scm")))
    (else (include "test-string-plus-encode.scm"))))
