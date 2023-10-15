
(define-library
  (euphrates labelinglogic-expression-sugarify-or)
  (export labelinglogic:expression:sugarify/or)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          for-each
          let
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-sugarify-or.scm")))
    (else (include
            "labelinglogic-expression-sugarify-or.scm"))))
