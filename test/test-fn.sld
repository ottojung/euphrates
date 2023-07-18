
(define-library
  (test-fn)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fn) fn))
  (import
    (only (scheme base) begin cond-expand let list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn.scm")))
    (else (include "test-fn.scm"))))
