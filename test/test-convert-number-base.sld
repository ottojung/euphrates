
(define-library
  (test-convert-number-base)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates convert-number-base)
          convert-number-base)
    (only (scheme base)
          begin
          car
          cdr
          cons
          for-each
          lambda
          let
          list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-convert-number-base.scm")))
    (else (include "test-convert-number-base.scm"))))
