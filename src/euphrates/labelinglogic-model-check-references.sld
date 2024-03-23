
(define-library
  (euphrates labelinglogic-model-check-references)
  (export labelinglogic:model:check-references)
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
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
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base)
          begin
          define
          for-each
          lambda
          list
          null?
          or
          quote
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
