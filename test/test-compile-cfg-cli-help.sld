
(define-library
  (test-compile-cfg-cli-help)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates compile-cfg-cli-help)
          CFG-AST->CFG-CLI-help)
    (only (euphrates current-program-path-p)
          current-program-path/p)
    (only (euphrates debug) debug)
    (only (euphrates define-cli)
          define-cli:raisu/p
          define-cli:show-help
          make-cli-with-handler
          with-cli)
    (only (scheme base)
          /
          _
          begin
          car
          define
          define-syntax
          lambda
          let
          map
          max
          parameterize
          quasiquote
          quote
          string?
          syntax-rules
          unquote)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-compile-cfg-cli-help.scm")))
    (else (include "test-compile-cfg-cli-help.scm"))))
