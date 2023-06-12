
(define-library
  (euphrates profun-op-lambda)
  (export profun-op-lambda)
  (import
    (only (euphrates compose) compose)
    (only (euphrates define-tuple) define-tuple)
    (only (euphrates profun-current-env-p)
          profun-current-env/p)
    (only (euphrates profun-op) make-profun-op)
    (only (euphrates profun-value)
          profun-value-unwrap)
    (only (euphrates profun-variable-arity-op-keyword)
          profun-variable-arity-op-keyword)
    (only (scheme base)
          _
          begin
          define
          define-syntax
          if
          lambda
          length
          let
          map
          pair?
          parameterize
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-lambda.scm")))
    (else (include "profun-op-lambda.scm"))))
