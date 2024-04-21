
(define-library
  (euphrates labelinglogic-expression-make)
  (export labelinglogic:expression:make)
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (scheme base)
          begin
          car
          cons
          define
          equal?
          if
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-make.scm")))
    (else (include "labelinglogic-expression-make.scm"))))
