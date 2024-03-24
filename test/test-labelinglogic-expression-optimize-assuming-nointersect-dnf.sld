
(define-library
  (test-labelinglogic-expression-optimize-assuming-nointersect-dnf)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/assuming-nointersect-dnf))
  (import (only (scheme base) = and begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-assuming-nointersect-dnf.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-assuming-nointersect-dnf.scm"))))
