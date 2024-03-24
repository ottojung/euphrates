(define-library
  (euphrates
    labelinglogic-model-optimize-assuming-nointersect)
  (export
    labelinglogic:model:optimize/assuming-nointersect)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-optimize-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-optimize-assuming-nointersect.scm"))))
