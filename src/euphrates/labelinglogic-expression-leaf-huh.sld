
(define-library
  (euphrates labelinglogic-expression-leaf-huh)
  (export labelinglogic:expression:leaf?)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          =
          begin
          define
          equal?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-leaf-huh.scm")))
    (else (include "labelinglogic-expression-leaf-huh.scm"))))
