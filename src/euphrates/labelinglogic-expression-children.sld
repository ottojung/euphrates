
(define-library
  (euphrates labelinglogic-expression-children)
  (export labelinglogic:expression:children)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-children.scm")))
    (else (include "labelinglogic-expression-children.scm"))))
