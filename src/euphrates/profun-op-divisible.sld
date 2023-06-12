
(define-library
  (euphrates profun-op-divisible)
  (export profun-op-divisible)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result)
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          +
          <
          =
          and
          begin
          define
          if
          let
          not
          number?
          or
          quote
          remainder)
    (only (srfi srfi-1) last))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-divisible.scm")))
    (else (include "profun-op-divisible.scm"))))
