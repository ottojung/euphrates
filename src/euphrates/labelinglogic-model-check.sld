
(define-library
  (euphrates labelinglogic-model-check)
  (export labelinglogic:model:check)
  (import (only (euphrates hashset) make-hashset))
  (import
    (only (euphrates labelinglogic-model-check-references)
          labelinglogic:model:check-references))
  (import
    (only (euphrates labelinglogic-model-check-structure)
          labelinglogic:model:check-structure))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-check.scm")))
    (else (include "labelinglogic-model-check.scm"))))
