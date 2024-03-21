
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
            labelinglogic-model-reduce-to-bindings)
          labelinglogic:model:reduce-to-bindings))
  (import
    (only (euphrates labelinglogic-model-sugarify)
          labelinglogic:model:sugarify))
  (import
    (only (euphrates labelinglogic-model-to-dnf)
          labelinglogic:model:to-dnf))
  (import
    (only (scheme base) begin car define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/labelinglogic.scm")))
    (else (include "labelinglogic.scm"))))
