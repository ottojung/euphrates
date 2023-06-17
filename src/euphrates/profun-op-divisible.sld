
(define-library
  (euphrates profun-op-divisible)
  (export profun-op-divisible)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import
    (only (euphrates profun-accept)
          profun-ctx-set
          profun-set))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-request-value)
          profun-request-value))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?))
  (import (only (euphrates raisu) raisu))
  (import
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
          remainder))
  (cond-expand
    (guile (import (only (srfi srfi-1) last)))
    (else (import (only (srfi 1) last))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-divisible.scm")))
    (else (include "profun-op-divisible.scm"))))
