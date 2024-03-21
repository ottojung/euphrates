
(define-library
  (euphrates
    labelinglogic-model-optimize-dnf-ands-assuming-nointersect)
  (export
    labelinglogic:model:optimize-dnf-ands-assuming-nointersect)
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect)
          labelinglogic:expression:optimize/and-assuming-nointersect))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-optimize-dnf-ands-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-optimize-dnf-ands-assuming-nointersect.scm"))))
