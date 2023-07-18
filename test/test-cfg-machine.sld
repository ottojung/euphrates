
(define-library
  (test-cfg-machine)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates cfg-machine) make-cfg-machine))
  (import
    (only (euphrates immutable-hashmap)
          immutable-hashmap->alist))
  (import
    (only (scheme base)
          =
          and
          begin
          cond-expand
          define
          define-values
          let
          list
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-cfg-machine.scm")))
    (else (include "test-cfg-machine.scm"))))
