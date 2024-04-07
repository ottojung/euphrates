
(define-library
  (euphrates labelinglogic-model-inline-all)
  (export labelinglogic:model:inline-all)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import
    (only (euphrates
            labelinglogic-expression-inline-references)
          labelinglogic:expression:inline-references))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-all.scm")))
    (else (include "labelinglogic-model-inline-all.scm"))))
