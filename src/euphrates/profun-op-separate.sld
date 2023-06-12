
(define-library
  (euphrates profun-op-separate)
  (export profun-op-separate)
  (import
    (only (euphrates profun-accept) profun-accept)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-variable-equal-q)
          profun-variable-equal?)
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
