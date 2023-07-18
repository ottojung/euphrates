
(define-library
  (test-md5)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates md5) md5-digest))
  (import (only (scheme base) begin cond-expand))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-md5.scm")))
    (else (include "test-md5.scm"))))
