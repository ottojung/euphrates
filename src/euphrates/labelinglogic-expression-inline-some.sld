
(define-library
  (euphrates labelinglogic-expression-inline-some)
  (export labelinglogic:expression:inline-some)
  (import
    (only (euphrates
            labelinglogic-expression-map-subexpressions)
          labelinglogic:expression:map-subexpressions))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-assoc)
          labelinglogic:model:assoc))
  (import
    (only (scheme base)
          and
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
               "euphrates/labelinglogic-expression-inline-some.scm")))
    (else (include
            "labelinglogic-expression-inline-some.scm"))))
