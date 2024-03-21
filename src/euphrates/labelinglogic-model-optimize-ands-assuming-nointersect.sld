
(define-library
  (euphrates
    labelinglogic-model-optimize-ands-assuming-nointersect)
  (export
    labelinglogic:model:optimize-ands-assuming-nointersect)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect)
          labelinglogic:expression:optimize/and-assuming-nointersect))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates
            labelinglogic-model-map-subexpressions)
          labelinglogic:model:map-subexpressions))
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
               "euphrates/labelinglogic-model-optimize-ands-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-model-optimize-ands-assuming-nointersect.scm"))))
