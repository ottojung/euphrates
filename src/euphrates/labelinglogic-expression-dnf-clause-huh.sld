
(define-library
  (euphrates
    labelinglogic-expression-dnf-clause-huh)
  (export labelinglogic:expression:dnf-clause?)
  (import
    (only (euphrates labelinglogic-expression-bottom-huh)
          labelinglogic:expression:bottom?))
  (import
    (only (euphrates
            labelinglogic-expression-lexeme-huh)
          labelinglogic:expression:lexeme?))
  (import
    (only (euphrates labelinglogic-expression-top-huh)
          labelinglogic:expression:top?))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-dnf-clause-huh.scm")))
    (else (include
            "labelinglogic-expression-dnf-clause-huh.scm"))))
