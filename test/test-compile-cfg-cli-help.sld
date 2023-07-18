
(define-library
  (test-compile-cfg-cli-help)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates compile-cfg-cli-help)
          CFG-AST->CFG-CLI-help))
  (import
    (only (euphrates current-program-path-p)
          current-program-path/p))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates define-cli)
          define-cli:raisu/p
          define-cli:show-help
          make-cli-with-handler
          with-cli))
  (import
    (only (scheme base)
          /
          _
          begin
          car
          cond-expand
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
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-compile-cfg-cli-help.scm")))
    (else (include "test-compile-cfg-cli-help.scm"))))
