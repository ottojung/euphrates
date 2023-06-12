
(define-library
  (euphrates profun-op-parameter)
  (export
    make-profun-parameter
    instantiate-profun-parameter)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result)
    (only (euphrates profun-accept) profun-set)
    (only (euphrates profun-current-env-p)
          profun-current-env/p)
    (only (euphrates profun-op) make-profun-op)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-value-unwrap)
    (only (euphrates raisu) raisu)
    (only (euphrates usymbol) make-usymbol)
    (only (scheme base)
          +
          =
          _
          begin
          cadr
          car
          case
          define
          else
          equal?
          if
          lambda
          length
          let
          or
          quote
          set!
          unless)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-1) count))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-parameter.scm")))
    (else (include "profun-op-parameter.scm"))))
