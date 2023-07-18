
(define-library
  (test-profune-communicator)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugv) debugv))
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
    (only (euphrates profun) profun-create-database))
  (import
    (only (euphrates profune-communicator)
          make-profune-communicator
          profune-communicator-handle))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          *
          +
          <
          =
          begin
          cdr
          cond-expand
          define
          equal?
          error
          length
          let
          list-ref
          null?
          quasiquote
          quote
          remainder
          unless))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-profune-communicator.scm")))
    (else (include "test-profune-communicator.scm"))))
