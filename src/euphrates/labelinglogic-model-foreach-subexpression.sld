(define-library
  (euphrates
    labelinglogic-model-foreach-subexpression)
  (export
    labelinglogic:model:foreach-subexpression)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-foreach-subexpression.scm")))
    (else (include
            "labelinglogic-model-foreach-subexpression.scm"))))
