
(define-library
  (euphrates labelinglogic-model-to-dnf)
  (export labelinglogic:model:to-dnf)
  (import
    (only (euphrates labelinglogic-expression-to-dnf)
          labelinglogic:expression:to-dnf))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-to-dnf.scm")))
    (else (include "labelinglogic-model-to-dnf.scm"))))
