
(define-library
  (test-make-cli)
  (import (only (euphrates assert) assert))
  (import (only (euphrates define-cli) make-cli))
  (import (only (euphrates hashmap) make-hashmap))
  (import
    (only (scheme base)
          /
          begin
          cond-expand
          define
          let
          list
          not))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-make-cli.scm")))
    (else (include "test-make-cli.scm"))))
