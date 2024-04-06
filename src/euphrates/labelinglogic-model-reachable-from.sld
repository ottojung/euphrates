
(define-library
  (euphrates labelinglogic-model-reachable-from)
  (export labelinglogic:model:reachable-from)
  (import (only (euphrates hashset) hashset-copy))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reachable-from.scm")))
    (else (include
            "labelinglogic-model-reachable-from.scm"))))
