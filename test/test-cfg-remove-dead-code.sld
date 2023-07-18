
(define-library
  (test-cfg-remove-dead-code)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates cfg-remove-dead-code)
          CFG-remove-dead-code))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          quasiquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-cfg-remove-dead-code.scm")))
    (else (include "test-cfg-remove-dead-code.scm"))))
