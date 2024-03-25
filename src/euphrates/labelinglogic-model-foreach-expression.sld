
(define-library
  (euphrates
    labelinglogic-model-foreach-expression)
  (export labelinglogic:model:foreach-expression)
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import
    (only (scheme base) begin define for-each lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-foreach-expression.scm")))
    (else (include
            "labelinglogic-model-foreach-expression.scm"))))
