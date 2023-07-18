
(define-library
  (test-fn-cons)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fn-cons) fn-cons))
  (import
    (only (euphrates list-zip-with) list-zip-with))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          -
          begin
          car
          cond-expand
          cons
          expt
          lambda
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn-cons.scm")))
    (else (include "test-fn-cons.scm"))))
