
(define-library
  (euphrates labelinglogic-expression-desugar)
  (export labelinglogic:expression:desugar)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates
            labelinglogic-expression-type-associative-huh)
          labelinglogic:expression:type:associative?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          begin
          car
          cddr
          cdr
          cond
          define
          else
          equal?
          if
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
               "euphrates/labelinglogic-expression-desugar.scm")))
    (else (include "labelinglogic-expression-desugar.scm"))))
