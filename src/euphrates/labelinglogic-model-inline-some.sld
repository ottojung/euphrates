
(define-library
  (euphrates labelinglogic-model-inline-some)
  (export labelinglogic:model:inline-some)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates
            labelinglogic-expression-inline-references)
          labelinglogic:expression:inline-references))
  (import
    (only (euphrates labelinglogic-model-filter)
          labelinglogic:model:filter))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-some.scm")))
    (else (include "labelinglogic-model-inline-some.scm"))))
