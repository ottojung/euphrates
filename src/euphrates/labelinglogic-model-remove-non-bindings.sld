
(define-library
  (euphrates
    labelinglogic-model-remove-non-bindings)
  (export labelinglogic:model:remove-non-bindings)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-remove-non-bindings.scm")))
    (else (include
            "labelinglogic-model-remove-non-bindings.scm"))))
