(define-library
  (euphrates
    labelinglogic-model-optimize-or-just-idempotency)
  (export
    labelinglogic:model:optimize/or/just-idempotency)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-optimize-or-just-idempotency.scm")))
    (else (include
            "labelinglogic-model-optimize-or-just-idempotency.scm"))))
