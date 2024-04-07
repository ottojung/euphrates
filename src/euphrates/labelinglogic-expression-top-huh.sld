
(define-library
  (euphrates labelinglogic-expression-top-huh)
  (export labelinglogic:expression:top?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-top-huh.scm")))
    (else (include "labelinglogic-expression-top-huh.scm"))))
