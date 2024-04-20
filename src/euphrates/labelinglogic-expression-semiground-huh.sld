
(define-library
  (euphrates
    labelinglogic-expression-semiground-huh)
  (export labelinglogic:expression:semiground?)
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
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-semiground-huh.scm")))
    (else (include
            "labelinglogic-expression-semiground-huh.scm"))))
