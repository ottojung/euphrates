
(define-library
  (test-labelinglogic-model-factor-dnf-clauses)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates
            labelinglogic-model-factor-dnf-clauses)
          labelinglogic:model:factor-dnf-clauses))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          define
          define-syntax
          equal?
          let
          not
          odd?
          or
          quasiquote
          quote
          syntax-rules
          unless))
  (import
    (only (scheme char)
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
             (include-from-path
               "test-labelinglogic-model-factor-dnf-clauses.scm")))
    (else (include
            "test-labelinglogic-model-factor-dnf-clauses.scm"))))
