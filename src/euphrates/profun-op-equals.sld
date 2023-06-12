
(define-library
  (euphrates profun-op-equals)
  (export profun-op-equals)
  (import
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-value)
          profun-unbound-value?)
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
