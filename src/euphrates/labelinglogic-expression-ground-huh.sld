
(define-library
  (euphrates labelinglogic-expression-ground-huh)
  (export labelinglogic:expression:ground?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-leaf-huh)
          labelinglogic:expression:leaf?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          let
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-ground-huh.scm")))
    (else (include
            "labelinglogic-expression-ground-huh.scm"))))
