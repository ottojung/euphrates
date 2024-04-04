
(define-library
  (euphrates
    labelinglogic-model-optimize-assuming-nointersect)
  (export
    labelinglogic:model:optimize/assuming-nointersect)
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (euphrates labelinglogic-model-inline-all)
          labelinglogic:model:inline-all))
  (import
    (only (euphrates
            labelinglogic-model-latticize-ands-assuming-nointersect-dnf)
          labelinglogic:model:latticize-ands-assuming-nointersect-dnf))
  (import
    (only (euphrates
            labelinglogic-model-optimize-or-just-idempotency)
          labelinglogic:model:optimize/or/just-idempotency))
  (import
    (only (euphrates
            labelinglogic-model-reduce-to-bindings)
          labelinglogic:model:reduce-to-bindings))
  (import
    (only (euphrates labelinglogic-model-reduce-to-names)
          labelinglogic:model:reduce-to-names))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-optimize-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-optimize-assuming-nointersect.scm"))))
