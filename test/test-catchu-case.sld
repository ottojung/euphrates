
(define-library
  (test-catchu-case)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates catchu-case) catchu-case)
    (only (euphrates dprintln) dprintln)
    (only (euphrates raisu) raisu)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          _
          apply
          begin
          cons
          define-syntax
          let
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-catchu-case.scm")))
    (else (include "test-catchu-case.scm"))))
