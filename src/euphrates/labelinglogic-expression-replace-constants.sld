
(define-library
  (euphrates
    labelinglogic-expression-replace-constants)
  (export
    labelinglogic::expression:replace-constants)
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
          if
          let
          map
          quote
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-replace-constants.scm")))
    (else (include
            "labelinglogic-expression-replace-constants.scm"))))
