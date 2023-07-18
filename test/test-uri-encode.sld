
(define-library
  (test-uri-encode)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates uri-encode) uri-encode))
  (import
    (only (scheme base) begin cond-expand define let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-uri-encode.scm")))
    (else (include "test-uri-encode.scm"))))
