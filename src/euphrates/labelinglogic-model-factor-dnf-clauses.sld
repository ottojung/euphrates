
(define-library
  (euphrates
    labelinglogic-model-factor-dnf-clauses)
  (export labelinglogic:model:factor-dnf-clauses)
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
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
    (only (scheme base)
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
               "euphrates/labelinglogic-model-factor-dnf-clauses.scm")))
    (else (include
            "labelinglogic-model-factor-dnf-clauses.scm"))))
