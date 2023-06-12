
(define-library
  (euphrates profun-standard-handler)
  (export profun-standard-handler)
  (import
    (only (euphrates profun-handler)
          profun-make-handler)
    (only (euphrates profun-op-divisible)
          profun-op-divisible)
    (only (euphrates profun-op-equals)
          profun-op-equals)
    (only (euphrates profun-op-false)
          profun-op-false)
    (only (euphrates profun-op-less) profun-op-less)
    (only (euphrates profun-op-modulo)
          profun-op-modulo)
    (only (euphrates profun-op-mult) profun-op*)
    (only (euphrates profun-op-plus) profun-op+)
    (only (euphrates profun-op-separate)
          profun-op-separate)
    (only (euphrates profun-op-sqrt) profun-op-sqrt)
    (only (euphrates profun-op-true) profun-op-true)
    (only (euphrates profun-op-unify)
          profun-op-unify)
    (only (scheme base) * + < = begin define modulo)
    (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-standard-handler.scm")))
    (else (include "profun-standard-handler.scm"))))
