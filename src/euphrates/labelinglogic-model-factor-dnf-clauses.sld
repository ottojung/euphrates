(define-library
  (euphrates
    labelinglogic-model-factor-dnf-clauses)
  (export labelinglogic:model:factor-dnf-clauses)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-factor-dnf-clauses.scm")))
    (else (include
            "labelinglogic-model-factor-dnf-clauses.scm"))))
