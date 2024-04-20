
(define-library
  (euphrates labelinglogic-binding-leaf-huh)
  (export labelinglogic:binding:leaf?)
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-expression-leaf-huh)
          labelinglogic:expression:leaf?))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-leaf-huh.scm")))
    (else (include "labelinglogic-binding-leaf-huh.scm"))))
