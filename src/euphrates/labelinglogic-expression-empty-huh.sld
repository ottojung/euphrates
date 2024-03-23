
(define-library
  (euphrates labelinglogic-expression-empty-huh)
  (export labelinglogic:expression:empty?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import
    (only (euphrates labelinglogic-expression-desugar)
          labelinglogic:expression:desugar))
  (import
    (only (euphrates
            labelinglogic-expression-move-nots-down)
          labelinglogic:expression:move-nots-down))
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
          let
          list
          member
          not
          null?
          or
          quote
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-empty-huh.scm")))
    (else (include
            "labelinglogic-expression-empty-huh.scm"))))
