
(define-library
  (test-compile-regex-cli)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates compile-regex-cli)
          compile-regex-cli:IR->Regex
          compile-regex-cli:make-IR)
    (only (euphrates const) const)
    (only (euphrates hashmap)
          hashmap->alist
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
             (include-from-path "test-compile-regex-cli.scm")))
    (else (include "test-compile-regex-cli.scm"))))
