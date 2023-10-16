
(define-library
  (euphrates labelinglogic-model-replace-constants)
  (export labelinglogic:model:replace-constants)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates
            labelinglogic-expression-replace-constants)
          labelinglogic:expression:replace-constants))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (scheme base)
          begin
          define
          equal?
          if
          lambda
          let
          list
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-replace-constants.scm")))
    (else (include
            "labelinglogic-model-replace-constants.scm"))))
