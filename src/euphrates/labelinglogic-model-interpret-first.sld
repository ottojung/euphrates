
(define-library
  (euphrates labelinglogic-model-interpret-first)
  (export labelinglogic:model:interpret/first)
  (import
    (only (euphrates labelinglogic-model-interpret)
          labelinglogic:model:interpret))
  (import
    (only (scheme base)
          begin
          car
          define
          if
          lambda
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-interpret-first.scm")))
    (else (include
            "labelinglogic-model-interpret-first.scm"))))
