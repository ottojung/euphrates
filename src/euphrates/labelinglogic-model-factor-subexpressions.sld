(define-library
  (euphrates
    labelinglogic-model-factor-subexpressions)
  (export
    labelinglogic:model:factor-subexpressions)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-factor-subexpressions.scm")))
    (else (include
            "labelinglogic-model-factor-subexpressions.scm"))))
