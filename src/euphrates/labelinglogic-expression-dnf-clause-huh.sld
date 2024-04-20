
(define-library
  (euphrates
    labelinglogic-expression-dnf-clause-huh)
  (export labelinglogic:expression:dnf-clause?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-atom-huh)
          labelinglogic:expression:atom?))
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
               "euphrates/labelinglogic-expression-dnf-clause-huh.scm")))
    (else (include
            "labelinglogic-expression-dnf-clause-huh.scm"))))
