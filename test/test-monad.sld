
(define-library
  (test-monad)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates compose-under) compose-under))
  (import
    (only (euphrates identity-monad) identity-monad))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import (only (euphrates log-monad) log-monad))
  (import
    (only (euphrates maybe-monad) maybe-monad))
  (import
    (only (euphrates monad-apply) monad-apply))
  (import
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont))
  (import
    (only (euphrates monad-parameterize)
          with-monad-left
          with-monad-right))
  (import (only (euphrates monadic-id) monadic-id))
  (import (only (euphrates monadic) monadic))
  (import
    (only (euphrates monadstate)
          monadstate-ret
          monadstate?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          *
          +
          _
          and
          begin
          call-with-values
          cond-expand
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
