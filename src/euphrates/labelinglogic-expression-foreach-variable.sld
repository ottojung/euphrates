
(define-library
  (euphrates
    labelinglogic-expression-foreach-variable)
  (export
    labelinglogic:expression:foreach-variable)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          =
          begin
          cond
          define
          else
          equal?
          for-each
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-foreach-variable.scm")))
    (else (include
            "labelinglogic-expression-foreach-variable.scm"))))
