
(define-library
  (euphrates labelinglogic-expression-huh)
  (export labelinglogic:expression?)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-huh.scm")))
    (else (include "labelinglogic-expression-huh.scm"))))
