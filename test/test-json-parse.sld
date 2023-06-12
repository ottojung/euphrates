
(define-library
  (test-json-parse)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates call-with-input-string)
          call-with-input-string)
    (only (euphrates json-parse) json-parse)
    (only (scheme base)
          begin
          define
          lambda
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-json-parse.scm")))
    (else (include "test-json-parse.scm"))))
