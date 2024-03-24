
(define-library
  (euphrates
    labelinglogic-expression-optimize-assuming-nointersect-dnf)
  (export
    labelinglogic:expression:optimize/assuming-nointersect-dnf)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-bottom-huh)
          labelinglogic:expression:bottom?))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/and-assuming-nointersect-dnf))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-singletons)
          labelinglogic:expression:optimize/singletons))
  (import
    (only (euphrates labelinglogic-expression-to-dnf)
          labelinglogic:expression:to-dnf))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-idempotent)
          list-idempotent))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates negate) negate))
  (import
    (only (scheme base)
          and
          begin
          cond
          define
          else
          equal?
          if
          lambda
          list
          map
          not
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-assuming-nointersect-dnf.scm")))
    (else (include
            "labelinglogic-expression-optimize-assuming-nointersect-dnf.scm"))))
