
(define-library
  (euphrates labelinglogic-expression-constants)
  (export labelinglogic:expression:constants)
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
               "euphrates/labelinglogic-expression-constants.scm")))
    (else (include
            "labelinglogic-expression-constants.scm"))))
