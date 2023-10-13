
(define-library
  (euphrates labelinglogic-expression-constants)
  (export labelinglogic::expression:constants)
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
          if
          let
          list
          map
          quote
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-constants.scm")))
    (else (include
            "labelinglogic-expression-constants.scm"))))
