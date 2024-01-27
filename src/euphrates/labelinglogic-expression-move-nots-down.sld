
(define-library
  (euphrates
    labelinglogic-expression-move-nots-down)
  (export labelinglogic:expression:move-nots-down)
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
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
          cond
          define
          else
          equal?
          list
          map
          member
          not
          or
          quote
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-move-nots-down.scm")))
    (else (include
            "labelinglogic-expression-move-nots-down.scm"))))
