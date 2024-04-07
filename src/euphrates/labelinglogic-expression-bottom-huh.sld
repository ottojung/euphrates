
(define-library
  (euphrates labelinglogic-expression-bottom-huh)
  (export labelinglogic:expression:bottom?)
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
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-bottom-huh.scm")))
    (else (include
            "labelinglogic-expression-bottom-huh.scm"))))
