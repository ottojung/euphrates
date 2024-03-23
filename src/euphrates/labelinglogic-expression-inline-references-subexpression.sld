
(define-library
  (euphrates
    labelinglogic-expression-inline-references-subexpression)
  (export
    labelinglogic:expression:inline-references/subexpression)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (scheme base)
          begin
          define
          equal?
          if
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-inline-references-subexpression.scm")))
    (else (include
            "labelinglogic-expression-inline-references-subexpression.scm"))))
