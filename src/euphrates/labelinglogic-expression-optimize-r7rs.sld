
(define-library
  (euphrates
    labelinglogic-expression-optimize-r7rs)
  (export labelinglogic:expression:optimize/r7rs)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          cons
          define
          define-values
          else
          equal?
          if
          lambda
          let
          list
          list-ref
          list?
          map
          not
          null?
          or
          pair?
          quasiquote
          quote
          unquote-splicing
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-r7rs.scm")))
    (else (include
            "labelinglogic-expression-optimize-r7rs.scm"))))
