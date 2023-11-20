
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
            labelinglogic-model-duplicate-bindings)
          labelinglogic:model:duplicate-bindings))
  (import
    (only (euphrates
            labelinglogic-model-extend-with-bindings)
          labelinglogic:model:extend-with-bindings))
  (import
    (only (euphrates
            labelinglogic-model-optimize-to-bindings)
          labelinglogic:model:optimize-to-bindings))
  (import
    (only (scheme base) begin car define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/labelinglogic.scm")))
    (else (include "labelinglogic.scm"))))
