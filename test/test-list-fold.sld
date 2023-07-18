
(define-library
  (test-list-fold)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (scheme base)
          *
          +
          _
          begin
          call-with-values
          cond-expand
          lambda
          let
          quote
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-fold.scm")))
    (else (include "test-list-fold.scm"))))
