
(define-library
  (euphrates
    labelinglogic-model-reduce-to-bindings)
  (export labelinglogic:model:reduce-to-bindings)
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-model-reduce-to-names)
          labelinglogic:model:reduce-to-names))
  (import (only (scheme base) begin define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-bindings.scm")))
    (else (include
            "labelinglogic-model-reduce-to-bindings.scm"))))
