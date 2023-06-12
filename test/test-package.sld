
(define-library
  (test-package)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates hashmap) hashmap-ref)
    (only (euphrates package)
          make-package
          use-svars
          with-package
          with-svars)
    (only (scheme base)
          begin
          cons
          define
          lambda
          let
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-package.scm")))
    (else (include "test-package.scm"))))
