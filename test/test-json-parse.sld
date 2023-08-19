
(define-library
  (test-json-parse)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates call-with-input-string)
          call-with-input-string))
  (import (only (euphrates json-parse) json-parse))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          lambda
          let
          not
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-64) test-error)))
    (else (import (only (srfi 64) test-error))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-json-parse.scm")))
    (else (include "test-json-parse.scm"))))
