
(define-library
  (test-fn)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates fn) fn)
    (only (scheme base) begin let list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn.scm")))
    (else (include "test-fn.scm"))))
