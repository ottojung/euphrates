
(define-library
  (test-regex-machine)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          make-hashmap))
  (import
    (only (euphrates regex-machine)
          make-regex-machine*))
  (import
    (only (scheme base)
          *
          +
          =
          and
          begin
          cond-expand
          define
          let
          list
          not
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-regex-machine.scm")))
    (else (include "test-regex-machine.scm"))))
