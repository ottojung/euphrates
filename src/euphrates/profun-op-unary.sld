
(define-library
  (euphrates profun-op-unary)
  (export profun-op-unary)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import
    (only (euphrates profun-accept) profun-set))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-request-value)
          profun-request-value))
  (import
    (only (euphrates profun-value)
          profun-bound-value?))
  (import
    (only (scheme base)
          =
          >=
          and
          begin
          cond
          define
          else
          if
          integer?
          let
          quasiquote
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-unary.scm")))
    (else (include "profun-op-unary.scm"))))
