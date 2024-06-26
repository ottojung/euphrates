
(define-library
  (euphrates labelinglogic-model-reachable-from)
  (export labelinglogic:model:reachable-from)
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-copy
          hashset-has?))
  (import
    (only (euphrates labelinglogic-expression-variables)
          labelinglogic:expression:variables))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (euphrates stack)
          list->stack
          stack-empty?
          stack-pop!
          stack-push!))
  (import
    (only (scheme base)
          begin
          define
          for-each
          lambda
          let
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reachable-from.scm")))
    (else (include
            "labelinglogic-model-reachable-from.scm"))))
