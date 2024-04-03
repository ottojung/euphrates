
(define-library
  (euphrates
    labelinglogic-model-collect-dnf-clauses)
  (export labelinglogic:model:collect-dnf-clauses)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          _
          begin
          define
          equal?
          for-each
          if
          lambda
          list
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-collect-dnf-clauses.scm")))
    (else (include
            "labelinglogic-model-collect-dnf-clauses.scm"))))
