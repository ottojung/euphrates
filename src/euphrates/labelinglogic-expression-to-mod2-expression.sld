
(define-library
  (euphrates
    labelinglogic-expression-to-mod2-expression)
  (export
    labelinglogic:expression->mod2-expression)
  (import
    (only (euphrates define-tuple) define-tuple))
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
          *
          +
          =
          and
          begin
          cadr
          car
          cddr
          cdr
          cond
          cons
          define
          define-values
          else
          equal?
          if
          length
          let
          list
          map
          member
          not
          or
          pair?
          quasiquote
          quote
          unquote
          unquote-splicing
          values))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-to-mod2-expression.scm")))
    (else (include
            "labelinglogic-expression-to-mod2-expression.scm"))))
