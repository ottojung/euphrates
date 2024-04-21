
(define-library
  (euphrates labelinglogic-expression-to-dnf)
  (export labelinglogic:expression:to-dnf)
  (import
    (only (euphrates cartesian-product)
          cartesian-product))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-move-nots-down)
          labelinglogic:expression:move-nots-down))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stack) stack-make))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          if
          lambda
          length
          let
          list
          map
          member
          not
          null?
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-to-dnf.scm")))
    (else (include "labelinglogic-expression-to-dnf.scm"))))
