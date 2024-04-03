
(define-library
  (euphrates labelinglogic-model-check-references)
  (export labelinglogic:model:check-references)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-has?
          hashset-intersection
          hashset-null?
          list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import
    (only (euphrates labelinglogic-model-names)
          labelinglogic:model:names))
  (import
    (only (euphrates list-get-duplicates)
          list-get-duplicates))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base)
          and
          begin
          cons
          define
          for-each
          lambda
          let
          list
          map
          member
          null?
          or
          quote
          reverse
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-check-references.scm")))
    (else (include
            "labelinglogic-model-check-references.scm"))))
