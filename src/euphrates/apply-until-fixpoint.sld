
(define-library
  (euphrates apply-until-fixpoint)
  (export apply-until-fixpoint)
  (import
    (only (scheme base) begin define equal? if let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/apply-until-fixpoint.scm")))
    (else (include "apply-until-fixpoint.scm"))))
