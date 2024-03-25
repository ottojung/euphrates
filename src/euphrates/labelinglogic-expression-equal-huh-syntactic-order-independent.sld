
(define-library
  (euphrates
    labelinglogic-expression-equal-huh-syntactic-order-independent)
  (export
    labelinglogic:expression:equal?/syntactic/order-independent)
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-ground-huh)
          labelinglogic:expression:ground?))
  (import
    (only (euphrates
            labelinglogic-expression-syntactic-equal-huh)
          labelinglogic:expression:syntactic-equal?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          cond
          define
          else
          equal?
          lambda
          length
          let
          list
          member
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-equal-huh-syntactic-order-independent.scm")))
    (else (include
            "labelinglogic-expression-equal-huh-syntactic-order-independent.scm"))))
