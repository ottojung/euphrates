
(define-library
  (euphrates
    labelinglogic-model-latticize-ands-assuming-nointersect-dnf)
  (export
    labelinglogic:model:latticize-ands-assuming-nointersect-dnf)
  (import (only (euphrates hashmap) make-hashmap))
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
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          if
          lambda
          let
          list
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-latticize-ands-assuming-nointersect-dnf.scm")))
    (else (include
            "labelinglogic-model-latticize-ands-assuming-nointersect-dnf.scm"))))
