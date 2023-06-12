
(define-library
  (test-regex-machine)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          make-hashmap)
    (only (euphrates regex-machine)
          make-regex-machine*)
    (only (scheme base)
          *
          =
          and
          begin
          define
          let
          list
          or
          quote)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-regex-machine.scm")))
    (else (include "test-regex-machine.scm"))))
