
(define-library
  (test-md5)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates md5) md5-digest)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-md5.scm")))
    (else (include "test-md5.scm"))))
