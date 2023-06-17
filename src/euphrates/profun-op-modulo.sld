
(define-library
  (euphrates profun-op-modulo)
  (export profun-op-modulo)
  (import
    (only (euphrates profun-accept)
          profun-accept
          profun-accept?
          profun-set))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import
    (only (euphrates profun-request-value)
          profun-request-value))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?))
  (import
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
          unquote))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-modulo.scm")))
    (else (include "profun-op-modulo.scm"))))
