
(define-library
  (euphrates profun)
  (export
    profun-create-database
    profun-create-falsy-database
    profun-eval-query
    profun-eval-query/boolean
    profun-eval-from
    profun-eval-from/generic
    profun-iterate
    profun-next
    profun-next/boolean)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates hashmap) hashmap->alist))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates profun-CR)
          profun-CR-what
          profun-CR?))
  (import
    (only (euphrates profun-IDR)
          make-profun-IDR
          profun-IDR?))
  (import
    (only (euphrates profun-RFC)
          profun-RFC-modify-iter
          profun-RFC?))
  (import
    (only (euphrates profun-abort)
          profun-abort-set-iter
          profun-abort?))
  (import
    (only (euphrates profun-accept)
          profun-accept-alist
          profun-accept-ctx
          profun-accept-ctx-changed?
          profun-accept?))
  (import
    (only (euphrates profun-database)
          make-falsy-profun-database
          make-profun-database
          profun-database-falsy?
          profun-database-get
          profun-database-handle
          profun-database?))
  (import
    (only (euphrates profun-env)
          make-profun-env
          profun-env-get
          profun-env-set!
          profun-env-unset!))
  (import
    (only (euphrates profun-error)
          make-profun-error
          profun-error-args
          profun-error?))
  (import
    (only (euphrates profun-instruction)
          profun-instruction-args
          profun-instruction-arity
          profun-instruction-body
          profun-instruction-build
          profun-instruction-constructor
          profun-instruction-context
          profun-instruction-name
          profun-instruction-next))
  (import
    (only (euphrates profun-iterator)
          profun-abort-insert
          profun-iterator-constructor
          profun-iterator-copy
          profun-iterator-db
          profun-iterator-env
          profun-iterator-query
          profun-iterator-state
          set-profun-iterator-state!))
  (import
    (only (euphrates profun-op-obj)
          profun-op-procedure))
  (import
    (only (euphrates profun-query-handle-underscores)
          profun-query-handle-underscores))
  (import
    (only (euphrates profun-reject) profun-reject?))
  (import
    (only (euphrates profun-rule)
          profun-rule-args
          profun-rule-body
          profun-rule-index
          profun-rule-name))
  (import
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
          set-profun-state-current))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-make-var
          profun-value-unwrap))
  (import
    (only (euphrates profun-varname-q)
          profun-varname?))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates usymbol) make-usymbol))
  (import
    (only (scheme base)
          +
          =
          _
          and
          begin
          boolean?
          car
          case
          cdr
          cond
          cond-expand
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
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter reverse!)))
    (else (import (only (srfi 1) filter reverse!))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun.scm")))
    (else (include "profun.scm"))))
