
(define-library
  (euphrates
    labelinglogic-expression-simplify-ground-terms)
  (export
    labelinglogic:expression:simplify-ground-terms)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-ground-huh)
          labelinglogic:expression:ground?))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          *
          =
          and
          begin
          cond
          define
          else
          equal?
          for-each
          let
          list
          map
          member
          not
          or
          quasiquote
          quote
          unless
          unquote-splicing))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-simplify-ground-terms.scm")))
    (else (include
            "labelinglogic-expression-simplify-ground-terms.scm"))))
