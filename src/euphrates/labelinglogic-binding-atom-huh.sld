
(define-library
  (euphrates labelinglogic-binding-atom-huh)
  (export labelinglogic:binding:atom?)
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-expression-atom-huh)
          labelinglogic:expression:atom?))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-atom-huh.scm")))
    (else (include "labelinglogic-binding-atom-huh.scm"))))
