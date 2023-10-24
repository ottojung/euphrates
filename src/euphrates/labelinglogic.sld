
(define-library
  (euphrates labelinglogic)
  (export labelinglogic:init)
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
          hashset-add!
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-bindings-check)
          labelinglogic:bindings:check))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-combine-recursively)
          labelinglogic:expression:combine-recursively))
  (import
    (only (euphrates labelinglogic-expression-desugar)
          labelinglogic:expression:desugar))
  (import
    (only (euphrates labelinglogic-expression-optimize)
          labelinglogic:expression:optimize))
  (import
    (only (euphrates
            labelinglogic-expression-replace-constants)
          labelinglogic:expression:replace-constants))
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
    (only (euphrates
            labelinglogic-model-calculate-biggest-universe)
          labelinglogic:model:calculate-biggest-universe))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (euphrates labelinglogic-model-factor-out-ors)
          labelinglogic:model:factor-out-ors))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
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
  (import
    (only (euphrates list-map-first) list-map-first))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
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
          cadr
          car
          cond
          define
          else
          equal?
          for-each
          if
          lambda
          let
          list
          list-ref
          map
          not
          null?
          or
          quasiquote
          quote
          unquote
          when))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/labelinglogic.scm")))
    (else (include "labelinglogic.scm"))))
