
(define-library
  (euphrates labelinglogic-expression-to-dnf)
  (export labelinglogic:expression:to-dnf)
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
  (import (only (euphrates raisu-star) raisu*))
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
          define
          else
          equal?
          if
          lambda
          let
          list
          map
          member
          not
          null?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-to-dnf.scm")))
    (else (include "labelinglogic-expression-to-dnf.scm"))))
