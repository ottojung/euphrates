(define-library
  (euphrates labelinglogic-model-check-references)
  (export labelinglogic:model:check-references)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-check-references.scm")))
    (else (include
            "labelinglogic-model-check-references.scm"))))
