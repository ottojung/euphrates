
(define-library
  (test-list-fold)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-fold) list-fold)
    (only (scheme base)
          *
          +
          _
          begin
          call-with-values
          lambda
          let
          quote
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-fold.scm")))
    (else (include "test-list-fold.scm"))))
