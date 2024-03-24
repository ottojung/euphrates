
(define-library
  (test-labelinglogic-expression-optimize-assuming-noninterset-dnf)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/and-assuming-nointersect-dnf))
  (import
    (only (scheme base) = and begin or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-assuming-noninterset-dnf.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-assuming-noninterset-dnf.scm"))))
