
(define-library
  (euphrates labelinglogic-model-bindings)
  (export labelinglogic:model:bindings)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-bindings.scm")))
    (else (include "labelinglogic-model-bindings.scm"))))
