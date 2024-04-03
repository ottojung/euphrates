
(define-library
  (euphrates
    labelinglogic-model-duplicate-bindings)
  (export labelinglogic:model:duplicate-bindings)
  (import (only (euphrates const) const))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          make-hashset))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-evaluate-r7rs)
          labelinglogic:expression:evaluate/r7rs))
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
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (scheme base)
          =
          and
          begin
          car
          cond
          define
          else
          equal?
          lambda
          let
          list
          or
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-duplicate-bindings.scm")))
    (else (include
            "labelinglogic-model-duplicate-bindings.scm"))))
