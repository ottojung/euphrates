
(define-library
  (test-monad-bind)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates identity-monad) identity-monad)
    (only (euphrates lines-to-string) lines->string)
    (only (euphrates log-monad) log-monad)
    (only (euphrates maybe-monad) maybe-monad)
    (only (euphrates monad-bind) monad-bind)
    (only (euphrates monad-do) monad-do)
    (only (euphrates with-monad) with-monad)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          *
          +
          _
          begin
          call-with-values
          define
          lambda
          let
          list
          newline
          quote
          values)
    (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-monad-bind.scm")))
    (else (include "test-monad-bind.scm"))))
