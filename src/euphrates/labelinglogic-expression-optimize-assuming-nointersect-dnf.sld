
(define-library
  (euphrates
    labelinglogic-expression-optimize-assuming-nointersect-dnf)
  (export
    labelinglogic:expression:optimize/assuming-nointersect-dnf)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import
    (only (euphrates cartesian-any-q) cartesian-any?))
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-bottom-huh)
          labelinglogic:expression:bottom?))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (euphrates
            labelinglogic-expression-is-subset-huh-assuming-nointersect-dnf-clause)
          labelinglogic:expression:is-subset?/assuming-nointersect-dnf-clause))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-dnf-clause-assuming-nointersect)
          labelinglogic:expression:optimize-dnf-clause/assuming-nointersect))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-singletons)
          labelinglogic:expression:optimize/singletons))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates
            labelinglogic-expression-syntactic-equal-huh)
          labelinglogic:expression:syntactic-equal?))
  (import
    (only (euphrates labelinglogic-expression-top-huh)
          labelinglogic:expression:top?))
  (import
    (only (euphrates labelinglogic-expression-top)
          labelinglogic:expression:top))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-consume) list-consume))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          and
          begin
          car
          cond
          define
          else
          equal?
          for-each
          if
          list
          map
          not
          or
          quote
          unless))
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
