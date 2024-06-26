
(define-library
  (euphrates
    labelinglogic-model-factor-dnf-clauses)
  (export labelinglogic:model:factor-dnf-clauses)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-model-factor-subexpressions)
          labelinglogic:model:factor-subexpressions))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          cond
          define
          else
          list
          member
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-factor-dnf-clauses.scm")))
    (else (include
            "labelinglogic-model-factor-dnf-clauses.scm"))))
