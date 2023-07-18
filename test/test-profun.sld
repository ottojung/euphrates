
(define-library
  (test-profun)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates debug) debug))
  (import (only (euphrates printf) printf))
  (import
    (only (euphrates profun-RFC)
          profun-RFC-insert
          profun-RFC-what
          profun-RFC?))
  (import
    (only (euphrates profun-accept) profun-accept))
  (import
    (only (euphrates profun-error)
          profun-error-args
          profun-error?))
  (import
    (only (euphrates profun-handler)
          profun-handler-extend))
  (import
    (only (euphrates profun-make-set)
          profun-make-set))
  (import
    (only (euphrates profun-make-tuple-set)
          profun-make-tuple-set))
  (import
    (only (euphrates profun-op-apply)
          profun-apply-fail!
          profun-apply-return!
          profun-op-apply))
  (import
    (only (euphrates profun-op-envlambda)
          profun-op-envlambda))
  (import
    (only (euphrates profun-op-eval)
          profun-eval-fail!
          profun-op-eval))
  (import
    (only (euphrates profun-op-function)
          profun-op-function))
  (import
    (only (euphrates profun-op-parameter)
          instantiate-profun-parameter
          make-profun-parameter))
  (import
    (only (euphrates profun-op-value)
          profun-op-value))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import
    (only (euphrates profun-standard-handler)
          profun-standard-handler))
  (import
    (only (euphrates profun)
          profun-create-database
          profun-eval-query
          profun-iterate
          profun-next))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
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
          values))
  (import (only (scheme eval) eval))
  (import (only (scheme inexact) sqrt))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (srfi srfi-1) any first second)))
    (else (import (only (srfi 1) any first second))))
  (cond-expand
    (guile (import (only (srfi srfi-64) test-error)))
    (else (import (only (srfi 64) test-error))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (ice-9 pretty-print) pretty-print))
           (begin (include-from-path "test-profun.scm")))
    (else (include "test-profun.scm"))))
