
(define-library
  (test-profune-communications)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates lines-to-string) lines->string)
    (only (euphrates printf) printf)
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
    (only (euphrates profun-op-value)
          profun-op-value)
    (only (euphrates profun) profun-create-database)
    (only (euphrates profune-communications-hook-p)
          profune-communications-hook/p)
    (only (euphrates profune-communications)
          profune-communications)
    (only (euphrates profune-communicator)
          make-profune-communicator)
    (only (euphrates tilda-a) ~a)
    (only (euphrates with-output-to-string)
          with-output-to-string)
    (only (euphrates words-to-string) words->string)
    (only (scheme base)
          *
          +
          <
          =
          _
          begin
          current-error-port
          current-output-port
          define
          equal?
          lambda
          map
          parameterize
          quasiquote
          quote
          unless)
    (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-profune-communications.scm")))
    (else (include "test-profune-communications.scm"))))
