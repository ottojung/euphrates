
(define-library
  (euphrates
    labelinglogic-model-duplicate-bindings)
  (export labelinglogic:model:duplicate-bindings)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates const) const))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-make-nondet-descriminator)
          labelinglogic:make-nondet-descriminator))
  (import
    (only (euphrates labelinglogic-model-flatten)
          labelinglogic:model:flatten))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (euphrates
            labelinglogic-model-reduce-to-bindings)
          labelinglogic:model:reduce-to-bindings))
  (import
    (only (euphrates labelinglogic-model-reduce-to-leafs)
          labelinglogic:model:reduce-to-leafs))
  (import
    (only (euphrates labelinglogic-model-replace-constants)
          labelinglogic:model:replace-constants))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-intersect-order-independent)
          list-intersect/order-independent))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          =
          and
          append
          apply
          assoc
          begin
          cond
          define
          else
          equal?
          if
          lambda
          let
          list
          map
          member
          not
          null?
          or
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-duplicate-bindings.scm")))
    (else (include
            "labelinglogic-model-duplicate-bindings.scm"))))
