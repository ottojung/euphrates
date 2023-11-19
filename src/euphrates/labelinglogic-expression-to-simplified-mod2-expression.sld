
(define-library
  (euphrates
    labelinglogic-expression-to-simplified-mod2-expression)
  (export
    labelinglogic:expression->simplified-mod2-expression)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
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
          cond
          cons
          define
          else
          equal?
          let
          list
          map
          member
          not
          or
          quasiquote
          quote
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-to-simplified-mod2-expression.scm")))
    (else (include
            "labelinglogic-expression-to-simplified-mod2-expression.scm"))))
