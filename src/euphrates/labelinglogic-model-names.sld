
(define-library
  (euphrates labelinglogic-model-names)
  (export labelinglogic:model:names)
  (import
    (only (scheme base) begin car define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-names.scm")))
    (else (include "labelinglogic-model-names.scm"))))
