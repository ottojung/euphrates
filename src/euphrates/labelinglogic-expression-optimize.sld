
(define-library
  (euphrates labelinglogic-expression-optimize)
  (export labelinglogic:expression:optimize)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-r7rs)
          labelinglogic:expression:optimize/r7rs))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          begin
          cond
          cons
          define
          else
          equal?
          map
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize.scm")))
    (else (include "labelinglogic-expression-optimize.scm"))))
