
(define-library
  (test-string-split-3)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates const) const))
  (import
    (only (euphrates string-split-3) string-split-3))
  (import
    (only (scheme base)
          begin
          cond-expand
          define-values
          lambda
          let
          member
          string->list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-split-3.scm")))
    (else (include "test-string-split-3.scm"))))
