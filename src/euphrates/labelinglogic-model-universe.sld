(define-library
  (euphrates labelinglogic-model-universe)
  (export labelinglogic:model:universe)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-universe.scm")))
    (else (include "labelinglogic-model-universe.scm"))))
