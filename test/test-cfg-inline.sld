
(define-library
  (test-cfg-inline)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates cfg-inline) CFG-inline)
    (only (euphrates debug) debug)
    (only (scheme base) begin define let quasiquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-cfg-inline.scm")))
    (else (include "test-cfg-inline.scm"))))
