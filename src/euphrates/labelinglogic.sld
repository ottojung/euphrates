
(define-library
  (euphrates labelinglogic)
  (export labelinglogic::init)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic::binding:expr))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic::binding:name))
  (import
    (only (euphrates labelinglogic-bindings-check)
          labelinglogic::bindings:check))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic::expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-replace-constants)
          labelinglogic::expression:replace-constants))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic::expression:type))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic::model:check))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          +
          =
          _
          append
          apply
          assq
          begin
          cadr
          car
          cond
          define
          else
          equal?
          for-each
          if
          lambda
          let
          list
          list-ref
          map
          not
          or
          quasiquote
          quote
          set!
          unquote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/labelinglogic.scm")))
    (else (include "labelinglogic.scm"))))
