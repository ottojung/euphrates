
(define-library
  (euphrates labelinglogic)
  (export labelinglogic:init)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
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
    (only (euphrates labelinglogic-bindings-check)
          labelinglogic:bindings:check))
  (import
    (only (euphrates
            labelinglogic-expression-combine-recursively)
          labelinglogic:expression:combine-recursively))
  (import
    (only (euphrates labelinglogic-expression-optimize)
          labelinglogic:expression:optimize))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (euphrates
            labelinglogic-model-extend-with-bindings)
          labelinglogic:model:extend-with-bindings))
  (import
    (only (euphrates labelinglogic-model-flatten)
          labelinglogic:model:flatten))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import
    (only (euphrates list-map-first) list-map-first))
  (import
    (only (scheme base)
          and
          begin
          car
          define
          equal?
          lambda
          map
          not))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/labelinglogic.scm")))
    (else (include "labelinglogic.scm"))))
