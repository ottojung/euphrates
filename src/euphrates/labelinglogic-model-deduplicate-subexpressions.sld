
(define-library
  (euphrates
    labelinglogic-model-deduplicate-subexpressions)
  (export
    labelinglogic:model:deduplicate-subexpressions)
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-append)
          labelinglogic:model:append))
  (import
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import
    (only (euphrates
            labelinglogic-model-foreach-subexpression)
          labelinglogic:model:foreach-subexpression))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import
    (only (euphrates labelinglogic-model-names)
          labelinglogic:model:names))
  (import
    (only (euphrates labelinglogic-model-reduce-to-names)
          labelinglogic:model:reduce-to-names))
  (import
    (only (euphrates multiset)
          make-multiset
          multiset-add!
          multiset-ref))
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
          <
          begin
          cond
          define
          else
          eq?
          equal?
          if
          lambda
          let
          not
          reverse
          set!
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-deduplicate-subexpressions.scm")))
    (else (include
            "labelinglogic-model-deduplicate-subexpressions.scm"))))
