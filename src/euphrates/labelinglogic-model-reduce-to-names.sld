
(define-library
  (euphrates labelinglogic-model-reduce-to-names)
  (export labelinglogic:model:reduce-to-names)
  (import
    (only (euphrates labelinglogic-model-reachable-from)
          labelinglogic:model:reachable-from))
  (import
    (only (euphrates
            labelinglogic-model-reduce-to-names-unsafe)
          labelinglogic:model:reduce-to-names/unsafe))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-names.scm")))
    (else (include
            "labelinglogic-model-reduce-to-names.scm"))))
