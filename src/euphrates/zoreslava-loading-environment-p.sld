
(define-library
  (euphrates zoreslava-loading-environment-p)
  (export zoreslava:loading-environment/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/zoreslava-loading-environment-p.scm")))
    (else (include "zoreslava-loading-environment-p.scm"))))
