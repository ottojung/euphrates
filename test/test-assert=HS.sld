
(define-library
  (test-assert=HS)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-assert=HS.scm")))
    (else (include "test-assert=HS.scm"))))
