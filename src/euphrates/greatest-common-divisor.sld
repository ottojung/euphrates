
(define-library
  (euphrates greatest-common-divisor)
  (export greatest-common-divisor)
  (import
    (only (scheme base)
          =
          abs
          begin
          cond
          define
          else
          let
          remainder))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/greatest-common-divisor.scm")))
    (else (include "greatest-common-divisor.scm"))))
