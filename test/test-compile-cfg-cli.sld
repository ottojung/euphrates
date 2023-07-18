
(define-library
  (test-compile-cfg-cli)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates compile-cfg-cli)
          CFG-CLI->CFG-lang))
  (import
    (only (scheme base)
          *
          /
          =
          and
          begin
          cond-expand
          define
          let
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compile-cfg-cli.scm")))
    (else (include "test-compile-cfg-cli.scm"))))
