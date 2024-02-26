
(define-library
  (euphrates
    labelinglogic-model-calculate-biggest-universe)
  (export
    labelinglogic:model:calculate-biggest-universe)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates list-intersect-order-independent)
          list-intersect))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          append
          apply
          assoc
          begin
          car
          cond
          define
          else
          equal?
          let
          list
          map
          or
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-calculate-biggest-universe.scm")))
    (else (include
            "labelinglogic-model-calculate-biggest-universe.scm"))))
