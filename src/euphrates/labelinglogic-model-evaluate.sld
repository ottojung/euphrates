(define-library
  (euphrates labelinglogic-model-evaluate)
  (export labelinglogic:model:evaluate)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-evaluate.scm")))
    (else (include "labelinglogic-model-evaluate.scm"))))
