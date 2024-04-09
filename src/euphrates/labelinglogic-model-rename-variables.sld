
(define-library
  (euphrates labelinglogic-model-rename-variables)
  (export labelinglogic:model:rename-variables)
  (import
    (only (euphrates define-tuple) define-tuple))
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
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-names)
          labelinglogic:model:names))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          define
          equal?
          for-each
          if
          lambda
          let
          list
          map
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-rename-variables.scm")))
    (else (include
            "labelinglogic-model-rename-variables.scm"))))
