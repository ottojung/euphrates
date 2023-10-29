
(define-library
  (euphrates
    labelinglogic-model-calculate-biggest-universe-typed)
  (export
    labelinglogic:model:calculate-biggest-universe/typed)
  (import
    (only (euphrates cartesian-product)
          cartesian-product))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-citizen-tuple)
          labelinglogic:citizen:tuple:make))
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
    (only (euphrates list-fold-right-semigroup)
          list-fold/right/semigroup))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates list-intersect-order-independent)
          list-intersect/order-independent))
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
          cdr
          cond
          cons
          define
          else
          equal?
          let
          list
          map
          member
          or
          quote
          reverse
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-calculate-biggest-universe-typed.scm")))
    (else (include
            "labelinglogic-model-calculate-biggest-universe-typed.scm"))))
