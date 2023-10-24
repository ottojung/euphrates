
(define-library
  (euphrates labelinglogic-model-map-expressions)
  (export labelinglogic:model:map-expressions)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (scheme base) begin define lambda map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-map-expressions.scm")))
    (else (include
            "labelinglogic-model-map-expressions.scm"))))
