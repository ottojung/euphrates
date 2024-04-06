(define-library
  (euphrates
    labelinglogic-model-reduce-to-names-unsafe)
  (export
    labelinglogic:model:reduce-to-names/unsafe)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-names-unsafe.scm")))
    (else (include
            "labelinglogic-model-reduce-to-names-unsafe.scm"))))
