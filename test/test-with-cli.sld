
(define-library
  (test-with-cli)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates command-line-arguments-p)
          command-line-argumets/p))
  (import (only (euphrates define-cli) with-cli))
  (import
    (only (scheme base)
          +
          /
          begin
          cond-expand
          define
          let
          list
          not
          number->string
          parameterize
          procedure?
          quote
          string-append
          string?))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-with-cli.scm")))
    (else (include "test-with-cli.scm"))))
