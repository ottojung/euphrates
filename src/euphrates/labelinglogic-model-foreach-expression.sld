(define-library
  (euphrates
    labelinglogic-model-foreach-expression)
  (export labelinglogic:model:foreach-expression)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-foreach-expression.scm")))
    (else (include
            "labelinglogic-model-foreach-expression.scm"))))
