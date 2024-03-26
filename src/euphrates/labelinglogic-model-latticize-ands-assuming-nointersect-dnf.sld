
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
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-bottom-huh)
          labelinglogic:expression:bottom?))
  (import
    (only (euphrates
            labelinglogic-expression-dnf-r7rs-clause-huh)
          labelinglogic:expression:dnf-r7rs-clause?))
  (import
    (only (euphrates
            labelinglogic-expression-equal-huh-syntactic-order-independent)
          labelinglogic:expression:equal?/syntactic/order-independent))
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
    (only (euphrates list-to-join-semilattice)
          list->join-semilattice))
  (import
    (only (euphrates olgraph-to-adjlist)
          olgraph->adjlist))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          _
          and
          begin
          cons
          define
          equal?
          for-each
          if
          lambda
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
