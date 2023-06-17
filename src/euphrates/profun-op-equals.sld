
(define-library
  (euphrates profun-op-equals)
  (export profun-op-equals)
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates profun-accept)
          profun-ctx-set
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
          profun-unbound-value?))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          define
          else
          if
          lambda
          let
          let*
          list?
          null?
          or
          pair?
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-equals.scm")))
    (else (include "profun-op-equals.scm"))))
