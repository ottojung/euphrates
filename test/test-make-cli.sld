
(define-library
  (test-make-cli)
  (import
    (only (euphrates assert) assert)
    (only (euphrates define-cli) make-cli)
    (only (euphrates hashmap) make-hashmap)
    (only (scheme base) / begin define let list not)
    (only (srfi srfi-42) :))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-make-cli.scm")))
    (else (include "test-make-cli.scm"))))
