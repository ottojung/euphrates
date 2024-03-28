
(define-library
  (euphrates labelinglogic)
  (export labelinglogic:init)
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates labelinglogic-bindings-check)
          labelinglogic:bindings:check))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (euphrates
            labelinglogic-model-extend-with-bindings)
          labelinglogic:model:extend-with-bindings))
  (import
    (only (euphrates labelinglogic-model-inline-all)
          labelinglogic:model:inline-all))
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
            labelinglogic-model-reduce-to-bindings)
          labelinglogic:model:reduce-to-bindings))
  (import
    (only (scheme base) begin car define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/labelinglogic.scm")))
    (else (include "labelinglogic.scm"))))
