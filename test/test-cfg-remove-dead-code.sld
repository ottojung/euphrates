
(define-library
  (test-cfg-remove-dead-code)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates cfg-remove-dead-code)
          CFG-remove-dead-code)
    (only (scheme base) begin define let quasiquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-cfg-remove-dead-code.scm")))
    (else (include "test-cfg-remove-dead-code.scm"))))
