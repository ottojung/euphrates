
(define-library
  (euphrates labelinglogic-model-flatten)
  (export labelinglogic:model:flatten)
  (import (only (euphrates const) const))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-map-expressions)
          labelinglogic:model:map-expressions))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!
          stack-unload!))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          =
          and
          append
          begin
          cond
          define
          else
          equal?
          let
          list
          map
          member
          not
          or
          quote
          reverse
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-flatten.scm")))
    (else (include "labelinglogic-model-flatten.scm"))))
