
(define-library
  (test-profune-communications)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import (only (euphrates printf) printf))
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
    (only (euphrates profun-op-value)
          profun-op-value))
  (import
    (only (euphrates profun) profun-create-database))
  (import
    (only (euphrates profune-communications-hook-p)
          profune-communications-hook/p))
  (import
    (only (euphrates profune-communications)
          profune-communications))
  (import
    (only (euphrates profune-communicator)
          make-profune-communicator))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          *
          +
          <
          =
          begin
          cond-expand
          current-error-port
          current-output-port
          define
          equal?
          lambda
          map
          parameterize
          quasiquote
          quote
          unless))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-profune-communications.scm")))
    (else (include "test-profune-communications.scm"))))
