
(define-library
  (euphrates labelinglogic-model-sugarify)
  (export labelinglogic:model:sugarify)
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-sugarify.scm")))
    (else (include "labelinglogic-model-sugarify.scm"))))
