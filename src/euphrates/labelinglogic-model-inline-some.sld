
(define-library
  (euphrates labelinglogic-model-inline-some)
  (export labelinglogic:model:inline-some)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          if
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-some.scm")))
    (else (include "labelinglogic-model-inline-some.scm"))))
