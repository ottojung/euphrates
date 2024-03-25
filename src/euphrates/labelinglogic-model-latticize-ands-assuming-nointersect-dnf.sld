
(define-library
  (euphrates
    labelinglogic-model-latticize-ands-assuming-nointersect-dnf)
  (export
    labelinglogic:model:latticize-ands-assuming-nointersect-dnf)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-bottom-huh)
          labelinglogic:expression:bottom?))
  (import
    (only (euphrates
            labelinglogic-expression-equal-huh-syntactic-order-independent)
          labelinglogic:expression:equal?/syntactic/order-independent))
  (import
    (only (euphrates labelinglogic-expression-huh)
          labelinglogic:expression?))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/assuming-nointersect-dnf))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import
    (only (euphrates list-idempotent-left)
          list-idempotent/left))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates list-to-join-semilattice)
          list->join-semilattice))
  (import (only (euphrates list-union) list-union))
  (import
    (only (euphrates olgraph-to-adjlist)
          olgraph->adjlist))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          _
          and
          begin
          define
          equal?
          for-each
          if
          lambda
          let
          list
          or
          quote
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-latticize-ands-assuming-nointersect-dnf.scm")))
    (else (include
            "labelinglogic-model-latticize-ands-assuming-nointersect-dnf.scm"))))
