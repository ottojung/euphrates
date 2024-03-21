
(define-library
  (euphrates
    labelinglogic-model-inline-non-bindings)
  (export labelinglogic:model:inline-non-bindings)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-non-bindings.scm")))
    (else (include
            "labelinglogic-model-inline-non-bindings.scm"))))
