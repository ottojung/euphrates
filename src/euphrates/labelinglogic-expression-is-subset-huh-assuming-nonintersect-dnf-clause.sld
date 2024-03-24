
(define-library
  (euphrates
    labelinglogic-expression-is-subset-huh-assuming-nonintersect-dnf-clause)
  (export
    labelinglogic:expression:is-subset?/assuming-nonintersect-dnf-clause)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-evaluate-r7rs)
          labelinglogic:expression:evaluate/r7rs))
  (import
    (only (euphrates
            labelinglogic-expression-syntactic-equal-huh)
          labelinglogic:expression:syntactic-equal?))
  (import
    (only (euphrates labelinglogic-expression-top-huh)
          labelinglogic:expression:top?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates list-zip) list-zip))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          car
          cdr
          cond
          define
          else
          equal?
          if
          lambda
          length
          let
          list
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-is-subset-huh-assuming-nonintersect-dnf-clause.scm")))
    (else (include
            "labelinglogic-expression-is-subset-huh-assuming-nonintersect-dnf-clause.scm"))))
