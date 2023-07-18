
(define-library
  (test-fn-tuple)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fn-tuple) fn-tuple))
  (import
    (only (euphrates list-zip-with) list-zip-with))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
          lambda
          let
          list
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn-tuple.scm")))
    (else (include "test-fn-tuple.scm"))))
