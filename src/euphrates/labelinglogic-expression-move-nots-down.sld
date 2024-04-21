
(define-library
  (euphrates
    labelinglogic-expression-move-nots-down)
  (export labelinglogic:expression:move-nots-down)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates labelinglogic-expression-top)
          labelinglogic:expression:top))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          =
          >=
          and
          begin
          car
          cond
          cons
          define
          else
          equal?
          if
          length
          let
          list
          list->vector
          map
          member
          not
          or
          quote
          reverse
          vector-ref))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-move-nots-down.scm")))
    (else (include
            "labelinglogic-expression-move-nots-down.scm"))))
