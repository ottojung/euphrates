
(define-library
  (euphrates profun-op-envlambda)
  (export profun-op-envlambda)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates profun-current-env-p)
          profun-current-env/p))
  (import
    (only (euphrates profun-op) make-profun-op))
  (import
    (only (euphrates profun-value)
          profun-value-unwrap))
  (import
    (only (euphrates profun-variable-arity-op-keyword)
          profun-variable-arity-op-keyword))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          if
          lambda
          length
          let
          pair?
          parameterize
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-envlambda.scm")))
    (else (include "profun-op-envlambda.scm"))))
