
(define-library
  (test-convert-number-base)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates convert-number-base)
          convert-number-base))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond-expand
          cons
          for-each
          lambda
          let
          list
          not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-convert-number-base.scm")))
    (else (include "test-convert-number-base.scm"))))
