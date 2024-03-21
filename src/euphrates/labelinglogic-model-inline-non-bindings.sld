
(define-library
  (euphrates
    labelinglogic-model-inline-non-bindings)
  (export labelinglogic:model:inline-non-bindings)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-assoc-or)
          labelinglogic:model:assoc-or))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          if
          lambda
          not
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-non-bindings.scm")))
    (else (include
            "labelinglogic-model-inline-non-bindings.scm"))))
