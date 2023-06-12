
(define-library
  (euphrates profun)
  (export
    profun-create-database
    profun-create-falsy-database
    profun-eval-query
    profun-eval-query/boolean
    profun-iterate
    profun-next
    profun-next/boolean)
  (import
    (only (euphrates comp) comp)
    (only (euphrates define-type9) define-type9)
    (only (euphrates fn-cons) fn-cons)
    (only (euphrates fn-pair) fn-pair)
    (only (euphrates hashmap) hashmap->alist)
    (only (euphrates identity) identity)
    (only (euphrates profun-CR)
          profun-CR-what
          profun-CR?)
    (only (euphrates profun-IDR)
          make-profun-IDR
          profun-IDR?)
    (only (euphrates profun-RFC)
          profun-RFC-modify-iter
          profun-RFC?)
    (only (euphrates profun-abort)
          profun-abort-set-iter
          profun-abort?)
    (only (euphrates profun-accept)
          profun-accept-alist
          profun-accept-ctx
          profun-accept-ctx-changed?
          profun-accept?)
    (only (euphrates profun-database)
          make-falsy-profun-database
          make-profun-database
          profun-database-falsy?
          profun-database-get
          profun-database-handle
          profun-database?)
    (only (euphrates profun-env)
          make-profun-env
          profun-env-get
          profun-env-set!
          profun-env-unset!)
    (only (euphrates profun-error)
          make-profun-error
          profun-error-args
          profun-error?)
    (only (euphrates profun-instruction)
          profun-instruction-args
          profun-instruction-arity
          profun-instruction-body
          profun-instruction-build
          profun-instruction-constructor
          profun-instruction-context
          profun-instruction-name
          profun-instruction-next)
    (only (euphrates profun-iterator)
          profun-abort-insert
          profun-iterator-constructor
          profun-iterator-copy
          profun-iterator-db
          profun-iterator-env
          profun-iterator-query
          profun-iterator-state
          set-profun-iterator-state!)
    (only (euphrates profun-op-obj)
          profun-op-procedure)
    (only (euphrates profun-query-handle-underscores)
          profun-query-handle-underscores)
    (only (euphrates profun-reject) profun-reject?)
    (only (euphrates profun-rule)
          profun-rule-args
          profun-rule-body
          profun-rule-index
          profun-rule-name)
    (only (euphrates profun-state)
          profun-state-build
          profun-state-constructor
          profun-state-current
          profun-state-failstate
          profun-state-final?
          profun-state-finish
          profun-state-stack
          profun-state-undo
          profun-state?
          set-profun-state-current)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-make-var
          profun-value-unwrap)
    (only (euphrates profun-varname-q)
          profun-varname?)
    (only (euphrates raisu) raisu)
    (only (euphrates usymbol) make-usymbol)
    (only (scheme base)
          +
          =
          and
          begin
          boolean?
          car
          case
          cdr
          cond
          cons
          define
          else
          equal?
          for-each
          if
          lambda
          let
          let*
          map
          not
          null?
          or
          pair?
          procedure?
          quote
          set!
          symbol?
          when)
    (only (srfi srfi-1) filter reverse!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun.scm")))
    (else (include "profun.scm"))))
