
(define-library
  (test-monad-bind)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates identity-monad) identity-monad))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import (only (euphrates log-monad) log-monad))
  (import
    (only (euphrates maybe-monad) maybe-monad))
  (import (only (euphrates monad-bind) monad-bind))
  (import (only (euphrates monad-do) monad-do))
  (import (only (euphrates with-monad) with-monad))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          *
          +
          _
          begin
          call-with-values
          cond-expand
          define
          lambda
          let
          list
          newline
          quote
          values))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-monad-bind.scm")))
    (else (include "test-monad-bind.scm"))))
