
(define-library
  (euphrates
    labelinglogic-expression-combine-recursively-or)
  (export
    labelinglogic:expression:combine-recursively/or)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import (only (euphrates list-fold) list-fold))
  (import
    (only (euphrates list-group-by) list-group-by))
  (import
    (only (scheme base)
          append
          apply
          begin
          cond
          cons
          define
          else
          equal?
          if
          lambda
          list
          map
          null?
          or
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-combine-recursively-or.scm")))
    (else (include
            "labelinglogic-expression-combine-recursively-or.scm"))))
