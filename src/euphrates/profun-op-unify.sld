
(define-library
  (euphrates profun-op-unify)
  (export profun-op-unify)
  (import
    (only (euphrates profun-accept)
          profun-accept
          profun-set)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-variable-equal-q)
          profun-variable-equal?)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          begin
          case
          define
          else
          quasiquote
          quote
          unquote)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-unify.scm")))
    (else (include "profun-op-unify.scm"))))
