
(define-library
  (euphrates
    parselynn-folexer-expression-to-labelinglogic-expression)
  (export
    parselynn:folexer:expression->labelinglogic:expression)
  (import
    (only (euphrates labelinglogic-expression-bottom)
          labelinglogic:expression:bottom))
  (import
    (only (euphrates labelinglogic-expression-huh)
          labelinglogic:expression?))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          =
          and
          begin
          car
          cdr
          char?
          cond
          define
          else
          lambda
          length
          let
          list
          list?
          map
          member
          not
          or
          pair?
          quote
          string->list
          string-length
          string-ref
          string?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-expression-to-labelinglogic-expression.scm")))
    (else (include
            "parselynn-folexer-expression-to-labelinglogic-expression.scm"))))
