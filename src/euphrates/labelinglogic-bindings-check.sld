
(define-library
  (euphrates labelinglogic-bindings-check)
  (export labelinglogic:bindings:check)
  (import
    (only (euphrates labelinglogic-model-check-references)
          labelinglogic:model:check-references))
  (import
    (only (euphrates labelinglogic-model-check-structure)
          labelinglogic:model:check-structure))
  (import (only (scheme base) begin define when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-bindings-check.scm")))
    (else (include "labelinglogic-bindings-check.scm"))))
