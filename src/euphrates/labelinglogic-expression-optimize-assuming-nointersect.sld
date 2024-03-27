
(define-library
  (euphrates
    labelinglogic-expression-optimize-assuming-nointersect)
  (export
    labelinglogic:expression:optimize/assuming-nointersect)
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/assuming-nointersect-dnf))
  (import
    (only (euphrates labelinglogic-expression-to-dnf)
          labelinglogic:expression:to-dnf))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-expression-optimize-assuming-nointersect.scm"))))
