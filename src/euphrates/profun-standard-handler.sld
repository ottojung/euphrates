
(define-library
  (euphrates profun-standard-handler)
  (export profun-standard-handler)
  (import
    (only (euphrates profun-handler)
          profun-make-handler))
  (import
    (only (euphrates profun-op-divisible)
          profun-op-divisible))
  (import
    (only (euphrates profun-op-equals)
          profun-op-equals))
  (import
    (only (euphrates profun-op-false)
          profun-op-false))
  (import
    (only (euphrates profun-op-less) profun-op-less))
  (import
    (only (euphrates profun-op-modulo)
          profun-op-modulo))
  (import
    (only (euphrates profun-op-mult) profun-op*))
  (import
    (only (euphrates profun-op-plus) profun-op+))
  (import
    (only (euphrates profun-op-separate)
          profun-op-separate))
  (import
    (only (euphrates profun-op-sqrt) profun-op-sqrt))
  (import
    (only (euphrates profun-op-true) profun-op-true))
  (import
    (only (euphrates profun-op-unify)
          profun-op-unify))
  (import
    (only (scheme base) * + < = begin define modulo))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-standard-handler.scm")))
    (else (include "profun-standard-handler.scm"))))
