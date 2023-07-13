
(define-library
  (test-profun)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates catchu-case) catchu-case)
    (only (euphrates debug) debug)
    (only (euphrates printf) printf)
    (only (euphrates profun-RFC)
          profun-RFC-insert
          profun-RFC-what
          profun-RFC?)
    (only (euphrates profun-accept) profun-accept)
    (only (euphrates profun-error)
          profun-error-args
          profun-error?)
    (only (euphrates profun-handler)
          profun-handler-extend)
    (only (euphrates profun-make-set)
          profun-make-set)
    (only (euphrates profun-make-tuple-set)
          profun-make-tuple-set)
    (only (euphrates profun-op-apply)
          profun-apply-fail!
          profun-apply-return!
          profun-op-apply)
    (only (euphrates profun-op-envlambda)
          profun-op-envlambda)
    (only (euphrates profun-op-eval)
          profun-eval-fail!
          profun-op-eval)
    (only (euphrates profun-op-function)
          profun-op-function)
    (only (euphrates profun-op-parameter)
          instantiate-profun-parameter
          make-profun-parameter)
    (only (euphrates profun-op-value)
          profun-op-value)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-standard-handler)
          profun-standard-handler)
    (only (euphrates profun)
          profun-create-database
          profun-eval-query
          profun-iterate
          profun-next)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          *
          +
          <
          =
          _
          and
          apply
          begin
          cond-expand
          define
          define-syntax
          else
          equal?
          error
          if
          lambda
          let
          list
          make-parameter
          modulo
          not
          or
          parameterize
          procedure?
          quasiquote
          quote
          quotient
          remainder
          set!
          syntax-rules
          unless
          unquote
          values)
    (only (scheme eval) eval)
    (only (scheme inexact) sqrt)
    (only (scheme write) write)
    (only (srfi srfi-1) any first second)
    (only (srfi srfi-64) test-error))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (ice-9 pretty-print) pretty-print))
           (begin (include-from-path "test-profun.scm")))
    (else (include "test-profun.scm"))))
