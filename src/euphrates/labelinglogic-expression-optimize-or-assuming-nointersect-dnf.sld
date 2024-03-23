(define-library
  (euphrates
    labelinglogic-expression-optimize-or-assuming-nointersect-dnf)
  (export
    labelinglogic:expression:optimize/or-assuming-nointersect-dnf)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-or-assuming-nointersect-dnf.scm")))
    (else (include
            "labelinglogic-expression-optimize-or-assuming-nointersect-dnf.scm"))))
