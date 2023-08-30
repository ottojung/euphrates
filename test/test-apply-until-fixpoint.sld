
(define-library
  (test-apply-until-fixpoint)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (scheme base) / begin floor lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-apply-until-fixpoint.scm")))
    (else (include "test-apply-until-fixpoint.scm"))))
