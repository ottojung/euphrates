
(define-library
  (test-appcomp)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates comp) appcomp comp)
    (only (scheme base)
          *
          +
          begin
          define
          expt
          lambda
          let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-appcomp.scm")))
    (else (include "test-appcomp.scm"))))
