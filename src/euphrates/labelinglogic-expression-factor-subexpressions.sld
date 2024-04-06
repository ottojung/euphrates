
(define-library
  (euphrates
    labelinglogic-expression-factor-subexpressions)
  (export
    labelinglogic:expression:factor-subexpressions)
  (import
    (only (euphrates labelinglogic-binding-make)
          labelinglogic:binding:make))
  (import
    (only (euphrates
            labelinglogic-expression-map-subexpressions)
          labelinglogic:expression:map-subexpressions))
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
          begin
          cond
          define
          else
          eq?
          lambda
          let
          reverse
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-factor-subexpressions.scm")))
    (else (include
            "labelinglogic-expression-factor-subexpressions.scm"))))
