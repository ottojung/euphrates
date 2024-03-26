
(define-library
  (euphrates
    labelinglogic-expression-dnf-r7rs-clause-huh)
  (export
    labelinglogic:expression:dnf-r7rs-clause?)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-huh)
          labelinglogic:expression?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-or-map) list-or-map))
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
               "euphrates/labelinglogic-expression-dnf-r7rs-clause-huh.scm")))
    (else (include
            "labelinglogic-expression-dnf-r7rs-clause-huh.scm"))))
