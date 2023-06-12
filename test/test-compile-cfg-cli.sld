
(define-library
  (test-compile-cfg-cli)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates compile-cfg-cli)
          CFG-CLI->CFG-lang)
    (only (scheme base)
          *
          /
          =
          and
          begin
          define
          let
          or
          quote)
    (only (srfi srfi-1) any)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compile-cfg-cli.scm")))
    (else (include "test-compile-cfg-cli.scm"))))
