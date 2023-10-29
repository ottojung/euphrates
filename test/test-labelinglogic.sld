
(define-library
  (test-labelinglogic)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates
            labelinglogic-model-calculate-biggest-universe-typed)
          labelinglogic:model:calculate-biggest-universe/typed))
  (import
    (only (euphrates
            labelinglogic-model-calculate-biggest-universe)
          labelinglogic:model:calculate-biggest-universe))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (euphrates labelinglogic)
          labelinglogic:init))
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
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-labelinglogic.scm")))
    (else (include "test-labelinglogic.scm"))))
