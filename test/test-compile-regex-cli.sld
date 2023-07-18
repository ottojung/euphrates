
(define-library
  (test-compile-regex-cli)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates compile-regex-cli)
          compile-regex-cli:IR->Regex
          compile-regex-cli:make-IR))
  (import (only (euphrates const) const))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          make-hashmap))
  (import
    (only (euphrates regex-machine)
          make-regex-machine*))
  (import
    (only (scheme base)
          *
          =
          and
          begin
          cond-expand
          define
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
             (include-from-path "test-compile-regex-cli.scm")))
    (else (include "test-compile-regex-cli.scm"))))
