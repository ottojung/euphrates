
(define-library
  (euphrates labelinglogic-model-evaluate-first)
  (export labelinglogic:model:evaluate/first)
  (import
    (only (euphrates labelinglogic-model-evaluate)
          labelinglogic:model:evaluate))
  (import
    (only (scheme base) begin car define if null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-evaluate-first.scm")))
    (else (include
            "labelinglogic-model-evaluate-first.scm"))))
