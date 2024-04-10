
(define-library
  (euphrates labelinglogic-model-foreach-variable)
  (export labelinglogic:model:foreach-variable)
  (import
    (only (euphrates
            labelinglogic-expression-foreach-variable)
          labelinglogic:expression:foreach-variable))
  (import
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-foreach-variable.scm")))
    (else (include
            "labelinglogic-model-foreach-variable.scm"))))
