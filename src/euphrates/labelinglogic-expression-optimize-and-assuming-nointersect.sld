
(define-library
  (euphrates
    labelinglogic-expression-optimize-and-assuming-nointersect)
  (export
    labelinglogic:expression:optimize/and-assuming-nointersect)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (euphrates
            labelinglogic-expression-evaluate-r7rs)
          labelinglogic:expression:evaluate/r7rs))
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (euphrates
            labelinglogic-expression-syntactic-equal-huh)
          labelinglogic:expression:syntactic-equal?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-annihilate)
          list-annihilate))
  (import
    (only (euphrates list-idempotent)
          list-idempotent))
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
          define
          equal?
          for-each
          if
          list
          not
          null?
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
               "euphrates/labelinglogic-expression-optimize-and-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-expression-optimize-and-assuming-nointersect.scm"))))
