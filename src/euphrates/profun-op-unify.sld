
(define-library
  (euphrates profun-op-unify)
  (export profun-op-unify)
  (import
    (only (euphrates profun-accept)
          profun-accept
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
    (only (euphrates profun-variable-equal-q)
          profun-variable-equal?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          begin
          case
          define
          else
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-unify.scm")))
    (else (include "profun-op-unify.scm"))))
