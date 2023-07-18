
(define-library
  (test-appcomp)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates comp) appcomp comp))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
          define
          expt
          lambda
          let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-appcomp.scm")))
    (else (include "test-appcomp.scm"))))
