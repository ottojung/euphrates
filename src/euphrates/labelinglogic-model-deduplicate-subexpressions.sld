
(define-library
  (euphrates
    labelinglogic-model-deduplicate-subexpressions)
  (export
    labelinglogic:model:deduplicate-subexpressions)
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import
    (only (euphrates multiset)
          make-multiset
          multiset-add!
          multiset-foreach/key-value))
  (import (only (euphrates stack) stack-make))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          <
          begin
          define
          lambda
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-deduplicate-subexpressions.scm")))
    (else (include
            "labelinglogic-model-deduplicate-subexpressions.scm"))))
