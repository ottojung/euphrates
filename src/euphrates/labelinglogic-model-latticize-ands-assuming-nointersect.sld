
(define-library
  (euphrates
    labelinglogic-model-latticize-ands-assuming-nointersect)
  (export
    labelinglogic:model:latticize-ands-assuming-nointersect)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-latticize-ands-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-latticize-ands-assuming-nointersect.scm"))))
