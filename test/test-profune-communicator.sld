
(define-library
  (test-profune-communicator)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates debugv) debugv)
    (only (euphrates profun-handler)
          profun-make-handler)
    (only (euphrates profun-op-divisible)
          profun-op-divisible)
    (only (euphrates profun-op-equals)
          profun-op-equals)
    (only (euphrates profun-op-false)
          profun-op-false)
    (only (euphrates profun-op-less) profun-op-less)
    (only (euphrates profun-op-mult) profun-op*)
    (only (euphrates profun-op-plus) profun-op+)
    (only (euphrates profun-op-separate)
          profun-op-separate)
    (only (euphrates profun-op-sqrt) profun-op-sqrt)
    (only (euphrates profun-op-true) profun-op-true)
    (only (euphrates profun-op-unify)
          profun-op-unify)
    (only (euphrates profun) profun-create-database)
    (only (euphrates profune-communicator)
          make-profune-communicator
          profune-communicator-handle)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          *
          +
          <
          =
          begin
          cdr
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
          unless)
    (only (scheme inexact) sqrt)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-profune-communicator.scm")))
    (else (include "test-profune-communicator.scm"))))
