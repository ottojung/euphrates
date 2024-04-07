
(define-library
  (euphrates labelinglogic-model-reachable-from)
  (export labelinglogic:model:reachable-from)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (euphrates stack)
          stack->list
          stack-copy
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
