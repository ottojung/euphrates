
(define-library
  (euphrates labelinglogic-binding-leaf-huh)
  (export labelinglogic:binding:leaf?)
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
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
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-leaf-huh.scm")))
    (else (include "labelinglogic-binding-leaf-huh.scm"))))
