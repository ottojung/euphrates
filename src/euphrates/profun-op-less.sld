
(define-library
  (euphrates profun-op-less)
  (export profun-op-less)
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
    (only (euphrates profun-reject) profun-reject))
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
          -
          <
          >=
          and
          begin
          define
          if
          let*
          not
          number?
          or
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-less.scm")))
    (else (include "profun-op-less.scm"))))
