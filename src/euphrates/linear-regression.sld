
(define-library
  (euphrates linear-regression)
  (export linear-regression)
  (import
    (only (scheme base)
          *
          +
          -
          /
          apply
          begin
          define
          lambda
          length
          let*
          map
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/linear-regression.scm")))
    (else (include "linear-regression.scm"))))
