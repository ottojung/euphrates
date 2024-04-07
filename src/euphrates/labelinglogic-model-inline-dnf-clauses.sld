
(define-library
  (euphrates
    labelinglogic-model-inline-dnf-clauses)
  (export labelinglogic:model:inline-dnf-clauses)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-inline-some)
          labelinglogic:model:inline-some))
  (import
    (only (scheme base)
          begin
          define
          equal?
          lambda
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-dnf-clauses.scm")))
    (else (include
            "labelinglogic-model-inline-dnf-clauses.scm"))))
