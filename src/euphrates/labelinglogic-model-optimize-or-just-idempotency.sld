
(define-library
  (euphrates
    labelinglogic-model-optimize-or-just-idempotency)
  (export
    labelinglogic:model:optimize/or/just-idempotency)
  (import (only (euphrates const) const))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-optimize-or-just-idempotency.scm")))
    (else (include
            "labelinglogic-model-optimize-or-just-idempotency.scm"))))
