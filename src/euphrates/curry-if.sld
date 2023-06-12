
(define-library
  (euphrates curry-if)
  (export curry-if)
  (import
    (only (euphrates identity) identity)
    (only (scheme base) begin define if lambda)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/curry-if.scm")))
    (else (include "curry-if.scm"))))
