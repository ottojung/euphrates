
(define-library
  (euphrates labelinglogic-model-assoc)
  (export labelinglogic:model:assoc)
  (import
    (only (euphrates labelinglogic-model-assoc-or)
          labelinglogic:model:assoc-or))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-assoc.scm")))
    (else (include "labelinglogic-model-assoc.scm"))))
