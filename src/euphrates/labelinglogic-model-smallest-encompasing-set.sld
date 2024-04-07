
(define-library
  (euphrates
    labelinglogic-model-smallest-encompasing-set)
  (export
    labelinglogic:model:smallest-encompasing-set)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-smallest-encompasing-set.scm")))
    (else (include
            "labelinglogic-model-smallest-encompasing-set.scm"))))
