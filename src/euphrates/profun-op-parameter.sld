
(define-library
  (euphrates profun-op-parameter)
  (export
    make-profun-parameter
    instantiate-profun-parameter)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import
    (only (euphrates profun-accept) profun-set))
  (import
    (only (euphrates profun-current-env-p)
          profun-current-env/p))
  (import
    (only (euphrates profun-op) make-profun-op))
  (import
    (only (euphrates profun-request-value)
          profun-request-value))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-value-unwrap))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates usymbol) make-usymbol))
  (import
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
          unless))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-parameter.scm")))
    (else (include "profun-op-parameter.scm"))))
