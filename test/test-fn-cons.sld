
(define-library
  (test-fn-cons)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates fn-cons) fn-cons)
    (only (euphrates list-zip-with) list-zip-with)
    (only (euphrates range) range)
    (only (scheme base)
          *
          +
          -
          begin
          car
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
