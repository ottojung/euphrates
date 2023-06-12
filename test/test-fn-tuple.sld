
(define-library
  (test-fn-tuple)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates fn-tuple) fn-tuple)
    (only (euphrates list-zip-with) list-zip-with)
    (only (euphrates range) range)
    (only (scheme base)
          *
          +
          begin
          lambda
          let
          list
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn-tuple.scm")))
    (else (include "test-fn-tuple.scm"))))
