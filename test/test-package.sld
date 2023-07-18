
(define-library
  (test-package)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates package)
          make-package
          use-svars
          with-package
          with-svars))
  (import
    (only (scheme base)
          begin
          cond-expand
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
