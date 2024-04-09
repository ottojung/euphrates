
(define-library
  (euphrates labelinglogic-model-replace-variables)
  (export labelinglogic:model:replace-variables)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (euphrates
            labelinglogic-expression-replace-variables)
          labelinglogic:expression:replace-variables))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (scheme base)
          begin
          define
          equal?
          if
          lambda
          let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-replace-variables.scm")))
    (else (include
            "labelinglogic-model-replace-variables.scm"))))
