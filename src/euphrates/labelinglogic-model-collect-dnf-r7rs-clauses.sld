
(define-library
  (euphrates
    labelinglogic-model-collect-dnf-r7rs-clauses)
  (export
    labelinglogic:model:collect-dnf-r7rs-clauses)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-dnf-r7rs-clause-huh)
          labelinglogic:expression:dnf-r7rs-clause?))
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
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-collect-dnf-r7rs-clauses.scm")))
    (else (include
            "labelinglogic-model-collect-dnf-r7rs-clauses.scm"))))
