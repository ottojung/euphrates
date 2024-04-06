(define-library
  (euphrates
    labelinglogic-model-deduplicate-subexpressions)
  (export
    labelinglogic:model:deduplicate-subexpressions)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-deduplicate-subexpressions.scm")))
    (else (include
            "labelinglogic-model-deduplicate-subexpressions.scm"))))
