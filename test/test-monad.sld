
(define-library
  (test-monad)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates compose-under) compose-under)
    (only (euphrates identity-monad) identity-monad)
    (only (euphrates lines-to-string) lines->string)
    (only (euphrates log-monad) log-monad)
    (only (euphrates maybe-monad) maybe-monad)
    (only (euphrates monad-apply) monad-apply)
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont)
    (only (euphrates monad-parameterize)
          with-monad-left
          with-monad-right)
    (only (euphrates monadic-id) monadic-id)
    (only (euphrates monadic) monadic)
    (only (euphrates monadstate)
          monadstate-ret
          monadstate?)
    (only (euphrates raisu) raisu)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          *
          +
          _
          and
          begin
          call-with-values
          define
          even?
          if
          lambda
          let
          list
          not
          number?
          quote
          set!
          string-append
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-monad.scm")))
    (else (include "test-monad.scm"))))
