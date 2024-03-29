
(define-library
  (euphrates
    labelinglogic-model-extend-with-bindings)
  (export labelinglogic:model:extend-with-bindings)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
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
          for-each
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
          unquote
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-extend-with-bindings.scm")))
    (else (include
            "labelinglogic-model-extend-with-bindings.scm"))))
