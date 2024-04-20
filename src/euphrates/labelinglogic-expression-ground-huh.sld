
(define-library
  (euphrates labelinglogic-expression-ground-huh)
  (export labelinglogic:expression:ground?)
  (import
    (only (euphrates labelinglogic-expression-variables)
          labelinglogic:expression:variables))
  (import (only (scheme base) begin define null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-ground-huh.scm")))
    (else (include
            "labelinglogic-expression-ground-huh.scm"))))
