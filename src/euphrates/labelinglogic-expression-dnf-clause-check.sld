
(define-library
  (euphrates
    labelinglogic-expression-dnf-clause-check)
  (export
    labelinglogic:expression:dnf-clause:check)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (euphrates
            labelinglogic-expression-dnf-clause-huh)
          labelinglogic:expression:dnf-clause?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          define
          list
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-dnf-clause-check.scm")))
    (else (include
            "labelinglogic-expression-dnf-clause-check.scm"))))
