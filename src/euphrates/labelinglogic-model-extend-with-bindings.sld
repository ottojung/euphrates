
(define-library
  (euphrates
    labelinglogic-model-extend-with-bindings)
  (export labelinglogic:model:extend-with-bindings)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-replace-constants)
          labelinglogic:model:replace-constants))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          and
          append
          begin
          define
          equal?
          for-each
          if
          lambda
          let
          list
          not
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-extend-with-bindings.scm")))
    (else (include
            "labelinglogic-model-extend-with-bindings.scm"))))
