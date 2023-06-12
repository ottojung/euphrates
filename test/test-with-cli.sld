
(define-library
  (test-with-cli)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates command-line-arguments-p)
          command-line-argumets/p)
    (only (euphrates define-cli) with-cli)
    (only (scheme base)
          +
          /
          begin
          define
          let
          list
          not
          number->string
          parameterize
          procedure?
          quote
          string-append
          string?)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-with-cli.scm")))
    (else (include "test-with-cli.scm"))))
