
(define-library
  (test-lambda-cli)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates define-cli) lambda-cli)
    (only (scheme base)
          /
          begin
          define
          let
          list
          string-append)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-lambda-cli.scm")))
    (else (include "test-lambda-cli.scm"))))
