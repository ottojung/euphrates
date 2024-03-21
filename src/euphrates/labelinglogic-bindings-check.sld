
(define-library
  (euphrates labelinglogic-bindings-check)
  (export labelinglogic:bindings:check)
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-binding-check)
          labelinglogic:binding:check))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import
    (only (euphrates list-and-map) list-and-map))
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
          begin
          car
          define
          for-each
          lambda
          list
          list?
          map
          null?
          or
          pair?
          quote
          symbol?
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-bindings-check.scm")))
    (else (include "labelinglogic-bindings-check.scm"))))
