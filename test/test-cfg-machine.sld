
(define-library
  (test-cfg-machine)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates assert) assert)
    (only (euphrates cfg-machine) make-cfg-machine)
    (only (euphrates immutable-hashmap)
          immutable-hashmap->alist)
    (only (scheme base)
          =
          and
          begin
          define
          define-values
          let
          list
          or
          quote)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-cfg-machine.scm")))
    (else (include "test-cfg-machine.scm"))))
