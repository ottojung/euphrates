
(define-library
  (euphrates labelinglogic-model-factor-out-ors)
  (export labelinglogic:model:factor-out-ors)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import
    (only (scheme base)
          append
          begin
          cond
          cons
          define
          else
          equal?
          lambda
          let
          list
          map
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-factor-out-ors.scm")))
    (else (include
            "labelinglogic-model-factor-out-ors.scm"))))
