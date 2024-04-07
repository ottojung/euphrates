
(define-library
  (euphrates labelinglogic-model-inline-some)
  (export labelinglogic:model:inline-some)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-some.scm")))
    (else (include "labelinglogic-model-inline-some.scm"))))
