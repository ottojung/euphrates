
(define-library
  (euphrates
    labelinglogic-model-optimize-assuming-nointersect)
  (export
    labelinglogic:model:optimize/assuming-nointersect)
  (import
    (only (euphrates
            labelinglogic-expression-optimize-assuming-nointersect)
          labelinglogic:expression:optimize/assuming-nointersect))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-optimize-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-optimize-assuming-nointersect.scm"))))
