
(define-library
  (test-lambda-cli)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates define-cli) lambda-cli))
  (import
    (only (scheme base)
          /
          begin
          cond-expand
          define
          let
          list
          string-append))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-lambda-cli.scm")))
    (else (include "test-lambda-cli.scm"))))
