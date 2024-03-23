
(define-library
  (euphrates labelinglogic-model-universe)
  (export labelinglogic:model:universe)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack) stack->list stack-make))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          _
          begin
          cond
          define
          else
          lambda
          list
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-universe.scm")))
    (else (include "labelinglogic-model-universe.scm"))))
