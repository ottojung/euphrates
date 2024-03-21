
(define-library
  (euphrates labelinglogic-model-inline-all)
  (export labelinglogic:model:inline-all)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import
    (only (scheme base)
          begin
          define
          equal?
          if
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-all.scm")))
    (else (include "labelinglogic-model-inline-all.scm"))))
