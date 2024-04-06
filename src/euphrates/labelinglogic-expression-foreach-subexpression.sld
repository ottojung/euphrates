
(define-library
  (euphrates
    labelinglogic-expression-foreach-subexpression)
  (export
    labelinglogic:expression:foreach-subexpression)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
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
          cond
          define
          else
          for-each
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
               "euphrates/labelinglogic-expression-foreach-subexpression.scm")))
    (else (include
            "labelinglogic-expression-foreach-subexpression.scm"))))
