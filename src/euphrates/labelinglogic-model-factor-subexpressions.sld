
(define-library
  (euphrates
    labelinglogic-model-factor-subexpressions)
  (export
    labelinglogic:model:factor-subexpressions)
  (import
    (only (euphrates
            labelinglogic-expression-factor-subexpressions)
          labelinglogic:expression:factor-subexpressions))
  (import
    (only (euphrates labelinglogic-model-append)
          labelinglogic:model:append))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          define
          define-values
          for-each
          lambda
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-factor-subexpressions.scm")))
    (else (include
            "labelinglogic-model-factor-subexpressions.scm"))))
