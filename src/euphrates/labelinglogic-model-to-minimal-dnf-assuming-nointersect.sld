
(define-library
  (euphrates
    labelinglogic-model-to-minimal-dnf-assuming-nointersect)
  (export
    labelinglogic:model:to-minimal-dnf/assuming-nointersect)
  (import
    (only (euphrates
            labelinglogic-model-deduplicate-subexpressions)
          labelinglogic:model:deduplicate-subexpressions))
  (import
    (only (euphrates
            labelinglogic-model-factor-dnf-clauses)
          labelinglogic:model:factor-dnf-clauses))
  (import
    (only (euphrates labelinglogic-model-inline-all)
          labelinglogic:model:inline-all))
  (import
    (only (euphrates
            labelinglogic-model-inline-dnf-clauses)
          labelinglogic:model:inline-dnf-clauses))
  (import
    (only (euphrates
            labelinglogic-model-latticize-ands-assuming-nointersect-dnf)
          labelinglogic:model:latticize-ands-assuming-nointersect-dnf))
  (import
    (only (euphrates
            labelinglogic-model-optimize-assuming-nointersect)
          labelinglogic:model:optimize/assuming-nointersect))
  (import
    (only (euphrates
            labelinglogic-model-optimize-or-just-idempotency)
          labelinglogic:model:optimize/or/just-idempotency))
  (import
    (only (euphrates
            labelinglogic-model-reduce-to-names-unsafe)
          labelinglogic:model:reduce-to-names/unsafe))
  (import
    (only (euphrates labelinglogic-model-reduce-to-names)
          labelinglogic:model:reduce-to-names))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-to-minimal-dnf-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-to-minimal-dnf-assuming-nointersect.scm"))))
