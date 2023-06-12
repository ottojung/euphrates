
(define-library
  (euphrates profun-op-modulo)
  (export profun-op-modulo)
  (import
    (only (euphrates profun-accept)
          profun-accept
          profun-accept?
          profun-set)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?)
    (only (scheme base)
          *
          +
          -
          /
          <
          >
          >=
          and
          begin
          case
          cond
          define
          else
          equal?
          if
          integer?
          or
          quasiquote
          quotient
          remainder
          unquote)
    (only (scheme case-lambda) case-lambda)
    (only (scheme inexact) sqrt)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-modulo.scm")))
    (else (include "profun-op-modulo.scm"))))
