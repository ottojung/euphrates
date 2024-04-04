
(define-library
  (test-labelinglogic-model-factor-dnf-clauses)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-model-alpha-rename)
          labelinglogic:model:alpha-rename))
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import
    (only (euphrates
            labelinglogic-model-minimize-assuming-nointersect)
          labelinglogic:model:minimize/assuming-nointersect))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          define
          define-syntax
          let
          map
          not
          or
          quasiquote
          quote
          syntax-rules))
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
