
(define-library
  (euphrates
    labelinglogic-expression-replace-constants)
  (export
    labelinglogic::expression:replace-constants)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic::expression:type))
  (import
    (only (scheme base)
          =
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-replace-constants.scm")))
    (else (include
            "labelinglogic-expression-replace-constants.scm"))))
