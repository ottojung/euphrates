(define-library
  (euphrates labelinglogic-model-check-structure)
  (export labelinglogic:model:check-structure)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-check-structure.scm")))
    (else (include
            "labelinglogic-model-check-structure.scm"))))
