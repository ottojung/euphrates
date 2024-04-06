(define-library
  (euphrates labelinglogic-model-reachable-from)
  (export labelinglogic:model:reachable-from)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reachable-from.scm")))
    (else (include
            "labelinglogic-model-reachable-from.scm"))))
