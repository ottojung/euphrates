
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
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-model-factor-dnf-clauses.scm")))
    (else (include
            "test-labelinglogic-model-factor-dnf-clauses.scm"))))
