
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
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          begin
          car
          cddr
          cdr
          cond
          define
          else
          equal?
          let
          list
          null?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-desugar.scm")))
    (else (include "labelinglogic-expression-desugar.scm"))))
