
(define-library
  (euphrates labelinglogic-expression-variables)
  (export labelinglogic:expression:variables)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          =
          append
          apply
          begin
          car
          cdr
          cond
          define
          else
          equal?
          let
          list
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-variables.scm")))
    (else (include
            "labelinglogic-expression-variables.scm"))))
