
(define-library
  (test-linear-regression)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates linear-regression)
          linear-regression))
  (import
    (only (scheme base)
          begin
          call-with-values
          cond-expand
          define
          lambda
          let
          map
          quote))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-linear-regression.scm")))
    (else (include "test-linear-regression.scm"))))
