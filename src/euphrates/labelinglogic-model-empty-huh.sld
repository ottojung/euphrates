
(define-library
  (euphrates labelinglogic-model-empty-huh)
  (export labelinglogic:model:empty?)
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import (only (scheme base) begin define null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-empty-huh.scm")))
    (else (include "labelinglogic-model-empty-huh.scm"))))
