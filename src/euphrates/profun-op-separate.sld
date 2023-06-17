
(define-library
  (euphrates profun-op-separate)
  (export profun-op-separate)
  (import
    (only (euphrates profun-accept) profun-accept))
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
  (import
    (only (scheme base)
          begin
          case
          define
          or
          quasiquote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-separate.scm")))
    (else (include "profun-op-separate.scm"))))
