
(define-library
  (test-list-idempotent)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-idempotent-model-alpha-rename)
          list-idempotent:model:alpha-rename))
  (import
    (only (euphrates list-idempotent-model-check)
          list-idempotent:model:check))
  (import
    (only (euphrates list-idempotent)
          list-idempotent:init))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          char?
          define
          lambda
          let
          not
          or
          quasiquote
          quote
          unquote))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-idempotent.scm")))
    (else (include "test-list-idempotent.scm"))))
