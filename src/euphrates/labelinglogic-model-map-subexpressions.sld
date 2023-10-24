
(define-library
  (euphrates
    labelinglogic-model-map-subexpressions)
  (export labelinglogic:model:map-subexpressions)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          and
          begin
          cond
          cons
          define
          else
          lambda
          let
          list
          map
          member
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-map-subexpressions.scm")))
    (else (include
            "labelinglogic-model-map-subexpressions.scm"))))
