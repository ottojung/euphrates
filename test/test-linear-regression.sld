
(define-library
  (test-linear-regression)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates linear-regression)
          linear-regression)
    (only (scheme base)
          begin
          call-with-values
          define
          lambda
          let
          map
          quote)
    (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-linear-regression.scm")))
    (else (include "test-linear-regression.scm"))))
