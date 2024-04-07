
(define-library
  (euphrates labelinglogic-model-inline-some)
  (export labelinglogic:model:inline-some)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates labelinglogic-expression-inline-some)
          labelinglogic:expression:inline-some))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          lambda
          not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-inline-some.scm")))
    (else (include "labelinglogic-model-inline-some.scm"))))
