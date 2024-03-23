
(define-library
  (euphrates
    labelinglogic-model-map-subexpressions)
  (export labelinglogic:model:map-subexpressions)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates
            labelinglogic-expression-map-subexpressions)
          labelinglogic:expression:map-subexpressions))
  (import
    (only (scheme base) begin define lambda map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-map-subexpressions.scm")))
    (else (include
            "labelinglogic-model-map-subexpressions.scm"))))
