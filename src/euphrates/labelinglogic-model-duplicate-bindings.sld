
(define-library
  (euphrates
    labelinglogic-model-duplicate-bindings)
  (export labelinglogic:model:duplicate-bindings)
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
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
            labelinglogic-make-nondet-descriminator)
          labelinglogic:make-nondet-descriminator))
  (import
    (only (euphrates
            labelinglogic-model-calculate-biggest-universe)
          labelinglogic:model:calculate-biggest-universe))
  (import
    (only (euphrates labelinglogic-model-flatten)
          labelinglogic:model:flatten))
  (import
    (only (euphrates labelinglogic-model-reduce-to-leafs)
          labelinglogic:model:reduce-to-leafs))
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
    (only (scheme base)
          =
          and
          append
          apply
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
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-duplicate-bindings.scm")))
    (else (include
            "labelinglogic-model-duplicate-bindings.scm"))))
